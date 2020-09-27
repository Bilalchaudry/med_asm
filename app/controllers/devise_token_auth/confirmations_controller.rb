module DeviseTokenAuth
  class ConfirmationsController < DeviseTokenAuth::ApplicationController
    include ErrorMessage

    #confirm user account
    def show
      begin
        @resource = User.find_by_confirmation_token params[:confirmation_token]
        if @resource.present? && @resource.update(confirmed_at: Time.now)
          render html: '<div>Congratulations! Your account is confirmed successfully </div>'.html_safe
        else
          bad_request_error(@resource.errors.to_sentence, 200)
        end
      rescue => error
        bad_request_error(error.message, 200)
      end
    end
  end
end