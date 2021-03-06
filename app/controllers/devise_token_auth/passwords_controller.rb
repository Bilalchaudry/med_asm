module DeviseTokenAuth
  class PasswordsController < DeviseTokenAuth::ApplicationController
    include UsersHelper
    before_action :set_user_by_token, only: [:update]
    # before_action :validate_redirect_url_param, only: [:create, :edit]

    # this action is responsible for generating password reset tokens and
    # sending emails
    def create
      return render_create_error_missing_email unless resource_params[:email]

      @email = get_case_insensitive_field_from_resource_params(:email)
      @resource = find_resource(:uid, @email)

      if @resource
        yield @resource if block_given?
        # @resource.send_reset_password_instructions(
        #     email: @email,
        #     provider: 'email',
        #     redirect_url: @redirect_url,
        #     client_config: params[:config_name]
        # )
        password_reset @resource

        if @resource.errors.empty?
          render_create_success
        else
          render_create_error @resource.errors
        end
      else
        render json: {
            success: false,
            message: "Unable to find user with email #{resource_params[:email]}."
        }
      end
    end

    # this is where users arrive after visiting the password reset confirmation link
    def edit
      # if a user is not found, return nil
      @resource = resource_class.with_reset_password_token(resource_params[:reset_password_token])

      if @resource && @resource.reset_password_period_valid?
        client_id, token = @resource.create_token

        # ensure that user is confirmed
        @resource.skip_confirmation! if confirmable_enabled? && !@resource.confirmed_at

        # allow user to change password once without current_password
        @resource.allow_password_change = true if recoverable_enabled?

        @resource.save!

        yield @resource if block_given?

        redirect_header_options = {reset_password: true}
        redirect_headers = build_redirect_headers(token,
                                                  client_id,
                                                  redirect_header_options)
        redirect_to(@resource.build_auth_url(@redirect_url,
                                             redirect_headers))
      else
        render_edit_error
      end
    end

    def update

      unless params[:reset_password_token].blank?
        @resource = User.find_by(reset_password_token: params[:reset_password_token])
      else
        @resource = User.find_by(phone: params[:phone])
      end

      render_not_found_error and return unless @resource.present?
      # ensure that password params were sent
      unless password_resource_params[:password] && password_resource_params[:password_confirmation]
        return render_update_error_missing_password
      end

      if @resource.send(resource_update_method, password_resource_params)
        @resource.allow_password_change = false if recoverable_enabled?
        token = @resource.create_token
        @client_id = token
        @token = token
        @resource.save!


        yield @resource if block_given?
        render 'devise_token_auth/sessions/log_in', status: :ok
      else
         render_update_error
      end
    end

    protected

    def resource_update_method
      allow_password_change = recoverable_enabled? && @resource.allow_password_change == true
      if DeviseTokenAuth.check_current_password_before_update == false || allow_password_change
        'update_attributes'
      else
        'update_with_password'
      end
    end

    def render_create_error_missing_email
      render_error(401, I18n.t('devise_token_auth.passwords.missing_email'))
    end

    def render_create_error_missing_redirect_url
      render_error(401, I18n.t('devise_token_auth.passwords.missing_redirect_url'))
    end

    def render_error_not_allowed_redirect_url
      response = {
          status: 'error',
          data: resource_data
      }
      message = I18n.t('devise_token_auth.passwords.not_allowed_redirect_url', redirect_url: @redirect_url)
      render_error(422, message, response)
    end

    def render_create_success
      render json: {
          success: true,
          token: @token
          # message: I18n.t('devise_token_auth.passwords.sended', email: @email)
      }, status: 200
    end

    def render_create_error(errors)
      render json: {
          success: false,
          errors: errors
      }, status: 400
    end

    def render_edit_error
      raise ActionController::RoutingError, 'Not Found'
    end

    def render_update_error_unauthorized
      render_error(401, 'Unauthorized')
    end

    def render_update_error_password_not_required
      render_error(422, I18n.t('devise_token_auth.passwords.password_not_required', provider: @resource.provider.humanize))
    end

    def render_update_error_missing_password
      render json: {
          success: false,
          errors: "Missing required parameters"
      }, status: 200
    end

    def render_update_success
      render json: {
          success: true,
          data: resource_data,
          message: I18n.t('devise_token_auth.passwords.successfully_updated')
      }
    end

    def render_update_error
      render json: {
          success: false,
          error: "Password mismatch"
      }, status: 200
    end

    private

    def resource_params
      params.permit(:email, :reset_password_token)
    end

    def password_resource_params
      params.permit(*params_for_resource(:account_update))
    end

    def render_not_found_error
      render json: {
        success: false,
        error: 'User not found'
      }, status: 404
    end

    def validate_redirect_url_param
      # give redirect value from params priority
      @redirect_url = params.fetch(
          :redirect_url,
          DeviseTokenAuth.default_password_reset_url
      )

      return render_create_error_missing_redirect_url unless @redirect_url
      return render_error_not_allowed_redirect_url if blacklisted_redirect_url?
    end
  end
end