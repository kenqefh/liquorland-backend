# frozen_string_literal: true

class Api::UsersController < ApiController
  skip_before_action :authorize, only: %i[create]

  def create
    user = User.create(user_params)
    if user.valid?
      user.save
      render json: user, except: %i[password_digest], status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: current_user, except: %i[password_digest], methods: [:avatar_url]
  end

  def index
    users = User.all
    render json: users, except: %i[token password_digest], methods: [:avatar_url]
  end

  def update
    if params[:avatar]
      # current_user.avatar.purge if current_user.avatar.attached?
      current_user.avatar.attach params[:avatar]
    end

    user_params = {}
    user_params[:name] = params[:name]  if params[:name]
    user_params[:email] = params[:email]  if params[:email]
    user_params[:direction] = params[:direction]  if params[:direction]
    user_params[:role] = params[:role]  if params[:role]
    user_params[:password] = params[:password]  if params[:password]
    user_params[:birth_date] = params[:birth_date]  if params[:birth_date]

    if current_user.update user_params
      render json: current_user, except: %i[password_digest], methods: :avatar_url
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :direction, :role, :password, :birth_date)
    end
end
