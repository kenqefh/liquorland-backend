# frozen_string_literal: true

class Api::UsersController < ApiController
  skip_before_action :authorize, only: %i[create]

  def create
    user = User.create(user_params)
    if user.valid?
      user.save
      render json: user, only: %i[id name email direction role token created_at], status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: current_user, only: %i[id name email direction role created_at], methods: [:get_url]
  end

  def index
    users = User.all
    render json: users, except: %i[token password_digest]
  end

  def update
    puts '//////////////////////////////////////////////////////////////////////'
    if params[:avatar]
      current_user.avatar.purge if current_user.avatar.attached?
      current_user.avatar.attach params[:avatar]
    end

    user_params = {}
    user_params[:name] = params[:name]  if params[:name]
    user_params[:email] = params[:email]  if params[:email]
    user_params[:direction] = params[:direction]  if params[:direction]
    user_params[:role] = params[:role]  if params[:role]
    current_user.update user_params

    puts '//////////////////////////////////////////////////////////////////////'
    # if @user.update(user_params)
    render json: current_user, except: %i[password_digest], methods: :get_url
    # else
    #   render json: @user.errors, status: :unprocessable_entity
    # end
    puts '//////////////////////////////////////////////////////////////////////'
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :direction, :role, :profile, :password, :birth_date)
    end
end
