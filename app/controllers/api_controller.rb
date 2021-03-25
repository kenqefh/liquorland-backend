# frozen_string_literal: true

class ApiController < ActionController::API
  # This is neened because ActionControlle::API doesn't include the module by default
  # This module is required for using authenticate_with_http_token method
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authorize

  # handle not found error
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def current_user
    @current_user ||= authenticate_token
  end

  def authorize
    authenticate_token || respond_unauthorized('Access denied')
  end

  private
    def respond_unauthorized(message)
      error = { unauthorized: message }
      render json: error, status: :unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, _options|
        User.find_by(token: token)
      end
    end

    def record_not_found
      render plain: '404 Not Found', status: 404
    end
end
