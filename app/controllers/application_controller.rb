class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token, raise: false

  def verify_user_logged_in?
    render json: {
        success: false,
        message: 'You need to sign in or sign up before continuing.'
    }, status: 200 and return unless user_signed_in?
  end


  def bad_request_error(message)
    render json: {
        success: false,
        message: message
    }, status: 422
  end
end
