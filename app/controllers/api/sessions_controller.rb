# frozen_string_literal: true

class Api::SessionsController < ApiController
  skip_before_action :authorize, only: :create

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      user.regenerate_token
      render json: { token: user.token }
    else
      respond_unauthorized('Incorrect email or password')
    end
  end

  def destroy
    current_user.invalidate_token
    head :ok
  end
end
