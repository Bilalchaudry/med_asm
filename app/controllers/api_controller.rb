class ApiController < ActionController::Base
	include ErrorMessage
  include DeviseTokenAuth::Concerns::SetUserByToken
  skip_before_action :verify_authenticity_token, raise: false

  def verify_user_logged_in?
    render json: {
        success: false,
        message: 'You need to sign in or sign up before continuing.'
    }, status: 401 and return unless user_signed_in?
  end

  def render_success(message, status)
    render json: {
        success: true,
        message: message
    }, status: status
  end

  def render_success_response(message)
    render json: {
        success: true,
        message: message
    }, status: 200
  end

  def missing_params
    render json: {
        success: false,
        message: 'Request missing required parameters'
    }, status: 400
  end

  def bad_request_error(message)
    render json: {
        success: false,
        message: message
    }, status: 422
  end

  def render_error(message, status)
    render json: {
        success: false,
        message: message
    }, status: status
  end

end