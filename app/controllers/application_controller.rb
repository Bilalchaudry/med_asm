class ApplicationController < ActionController::Base
        skip_before_action :verify_authenticity_token, raise: false
        include DeviseTokenAuth::Concerns::SetUserByToken
        def bad_request_error(message, status)
                render json: {
                    success: false,
                    message: message,
                }, status: status
        end
end
