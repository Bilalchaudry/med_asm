module DeviseTokenAuth
  class RegistrationsController < DeviseTokenAuth::ApplicationController
    include ErrorMessage
    before_action :set_user_by_token, only: [:destroy, :update]
    skip_after_action :update_auth_header, only: [:destroy]


    def create
      begin
        @resource = User.new(user_params)
        update_header_tokens if @resource.save!
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
            yield @resource if block_given?
            @all_slots = @resource.slots
            @morning_slots = @all_slots.where(day_time: 'Morning');
            @noon_slots = @all_slots.where(day_time: 'Noon');
            @evening_slots = @all_slots.where(day_time: 'Evening');
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

    private

    def user_params
      params.require(:user).permit(:email, :full_name, :phone, :password, :password_confirmation,
                                   :gender, :image)
    end


    def account_update_params
      params.require(:user).permit(:email, :full_name, :phone, :gender, :age, :blood_group, :image)
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