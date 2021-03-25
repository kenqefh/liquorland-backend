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
    user = User.find(params[:id])
    render json: user, only: %i[id name email direction role token created_at]
    rescue
      render json: error: 'Not found', status: :not_found
  end

  def index
    users = User.all
    render json: users, only: %i[id name email direction role token created_at]
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :direction, :role, :profile, :password)
    end
end
