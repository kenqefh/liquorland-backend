# frozen_string_literal: true

class Api::UsersController < ApiController
  skip_before_action :authorize, only: %i[create]
  before_action :set_user, only: %i[show update]

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
    render json: @user, only: %i[id name email direction role created_at]
  end

  def index
    users = User.all
    render json: users, only: %i[id name email direction role created_at]
  end

  def update
    if @user.update(user_params)
      render json: @user, only: %i[id name email direction role token created_at updated_at]
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :direction, :role, :profile, :password)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
