# frozen_string_literal: true

class Api::UsersController < ApiController
  def show
    user = User.find(params[:id])
    render json: user, only: %i[id name email direction role token created_at]
  end

  def index
    users = User.all
    render json: users, only: %i[id name email direction role token created_at]
  end
end
