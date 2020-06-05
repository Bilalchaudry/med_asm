# frozen_string_literal: true

# see http://www.emilsoman.com/blog/2013/05/18/building-a-tested/
module DeviseTokenAuth
  class SessionsController < DeviseTokenAuth::ApplicationController
    # include ErrorMessage
    before_action :set_user_by_token, only: :destroy
    # before_action :validate_sign_in_params, only: :create
    after_action :reset_session, only: :destroy

    def new
      render_new_error
    end

    def update_header_tokens
      @client_id, @token = @resource.create_token
      @resource.save!
      update_auth_header
    end

    def create
      begin
        @resource = User.email_or_phone_exist?(params[:user][:login]).first
        return bad_request_error("User not found", 200) unless @resource.present?
        if @resource.valid_password? params[:user][:password]
          
          token = @resource.create_token
          @client_id = token
          @token = token

          # if params[:user][:device_token].present?
          #   @resource.device_token = params[:user][:device_token]
          # end
          
          @resource.save!
          yield @resource if block_given?
          render :log_in, status: :ok
        else
          bad_request_error("Invalid Login Credentials", 200)
        end
      rescue => error
        bad_request_error(error.message, 200)
      end
    end

    def destroy
      # remove auth instance variables so that after_action does not run
      user = remove_instance_variable(:@resource) if @resource
      client_id = request.headers["client"]
      remove_instance_variable(:@token) if @token

      if user && client_id && user.tokens[client_id]
        user.tokens.delete(request.headers["client"])
        user.save!

        yield user if block_given?

        render_destroy_success
      else
        render_destroy_error
      end
    end

    protected

    def valid_params?(key, val)
      resource_params[:password] && key && val
    end

    def get_auth_params
      auth_key = nil
      auth_val = nil

      # iterate thru allowed auth keys, use first found
      resource_class.authentication_keys.each do |k|
        if resource_params[k]
          auth_val = resource_params[k]
          auth_key = k
          break
        end
      end

      # honor devise configuration for case_insensitive_keys
      if resource_class.case_insensitive_keys.include?(auth_key)
        auth_val.downcase!
      end

      {key: auth_key, val: auth_val}
    end

    def render_new_error
      render_error(405, I18n.t('devise_token_auth.sessions.not_supported'))
    end

    def render_create_success
      render json: {
          data: resource_data(resource_json: @resource.token_validation_response)
      }
    end

    def render_create_error_not_confirmed
      render_error(401, I18n.t('devise_token_auth.sessions.not_confirmed', email: @resource.email))
    end

    def render_create_error_account_locked
      render_error(401, I18n.t('devise.mailer.unlock_instructions.account_lock_msg'))
    end

    def render_create_error_bad_credentials
      render_error(401, I18n.t('devise_token_auth.sessions.bad_credentials'))
    end

    def render_destroy_success
      render json: {
          success: true,
          message: "User log out successfully"
      }, status: 200
    end

    def render_destroy_error
      render json: {
          success: false,
          status: "Invalid Request"
      }, status: 400
    end

    private

    def resource_params
      params.permit(*params_for_resource(:sign_in))
    end
  end
end