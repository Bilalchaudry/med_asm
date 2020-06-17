module DeviseTokenAuth
  class RegistrationsController < DeviseTokenAuth::ApplicationController
    include ErrorMessage
    before_action :set_user_by_token, only: [:destroy, :update]
    skip_after_action :update_auth_header, only: [:destroy]
    # before_action :validate_sign_up_params, only: :create
    # caches_page :new

    # def validate_sign_up_params
    #   email = params[:user][:email]
    #   user_name = params[:user][:user_name]
    #   password = params[:user][:password]
    #   password_confirmation = params[:user][:password_confirmation]
    #   phone = params[:user][:phone]
    #
    #   bad_request_error('Missing required parameters', 400) if email.nil? ||
    #       user_name.nil? || password.nil? || password_confirmation.nil? || phone.nil?
    # end


    def create
      begin
        @resource = User.new(user_params)
        update_header_tokens if @resource.save!
        @resource.create_image(image: params[:user][:image]) if params[:user][:image].present?
        render :sign_up, status: :created
      rescue => error
        bad_request_error(error.message, 200)
      end
    end

    def confirm_user
      @user = User.find_by_confirmation_token params[:token]
      if @user.confirmed_at?
        @user.update(confirmed_at: Time.now)
        render json: {
            success: false,
            message: "User confirmed successfully."
        }, status: 200
      else
        render json: {
            success: false,
            message: "User already confirmed."
        }, status: 200
      end
    end

    def update
      begin
        if @resource
          if @resource.send(resource_update_method, account_update_params)
            if params[:user][:image].present?
              @resource.image.present? ? @resource.image.update(image: params[:user][:image]) : @resource.create_image(image: params[:user][:image])
            end
            yield @resource if block_given?
            render :update, status: :ok
          else
            bad_request_error(@resource.errors.full_messages.to_sentence, 200)
          end
        else
          bad_request_error("User not found", 200)
        end
      rescue => error
        bad_request_error error.message, 400
      end
    end

    def destroy
      if @resource
        @resource.destroy
        yield @resource if block_given?
        render_destroy_success
      else
        render_destroy_error
      end
    end

    def sign_up_params
      params.permit(*params_for_resource(:sign_up))
    end

    protected

    def update_header_tokens
      token = @resource.create_token
      @client_id = token
      @token = token
      @resource.save!
      update_auth_header
    end

    def build_resource
      @resource = resource_class.new(sign_up_params)
      @resource.provider = provider

      # honor devise configuration for case_insensitive_keys
      if resource_class.case_insensitive_keys.include?(:email)
        @resource.email = sign_up_params[:email].try(:downcase)
      else
        @resource.email = sign_up_params[:email]
      end
    end

    def render_create_error_missing_confirm_success_url
      response = {
          status: 'error',
          data: resource_data
      }
      message = I18n.t('devise_token_auth.registrations.missing_confirm_success_url')
      render_error(422, message, response)
    end

    def render_create_error_redirect_url_not_allowed
      response = {
          status: 'error',
          data: resource_data
      }
      message = I18n.t('devise_token_auth.registrations.redirect_url_not_allowed', redirect_url: @redirect_url)
      render_error(422, message, response)
    end

    def render_update_error_user_not_found
      render_error(404, I18n.t('devise_token_auth.registrations.user_not_found'), status: 'error')
    end

    def render_destroy_success
      render json: {
          status: 'success',
          message: I18n.t('devise_token_auth.registrations.account_with_uid_destroyed', uid: @resource.uid)
      }
    end

    def render_destroy_error
      render_error(404, I18n.t('devise_token_auth.registrations.account_to_destroy_not_found'), status: 'error')
    end

    private

    def user_params
      params.require(:user).permit(:email, :full_name, :phone, :password, :password_confirmation,
                                   :gender)
    end


    def account_update_params
      params.require(:user).permit(:email, :full_name, :phone, :gender)
    end

    def resource_update_method
      if DeviseTokenAuth.check_current_password_before_update == :attributes
        'update_with_password'
      elsif DeviseTokenAuth.check_current_password_before_update == :password && account_update_params.key?(:password)
        'update_with_password'
      elsif account_update_params.key?(:current_password)
        'update_with_password'
      else
        'update_attributes'
      end
    end

    def validate_account_update_params
      validate_post_data account_update_params, I18n.t('errors.messages.validate_account_update_params')
    end

    def validate_post_data which, message
      render_error(:unprocessable_entity, message, status: 'error') if which.empty?
    end

    def active_for_authentication?
      !@resource.respond_to?(:active_for_authentication?) || @resource.active_for_authentication?
    end
  end
end