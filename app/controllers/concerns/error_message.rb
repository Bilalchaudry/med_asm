module ErrorMessage

  def validate_sign_up_request
    if params[:user] && params[:user][:email].present? && params[:user][:password].present? && params[:user][:password_confirmation].present? && params[:user][:user_name].present? && params[:user][:phone].present?
      if User.where("email = ? AND phone = ? ", params[:user][:email], params[:user][:phone]).first.present?
        return already_exist_error 'Email and phone number is already used with another account'
      elsif User.where("email = ? ", params[:user][:email]).exists?
        return already_exist_error 'Email is already used with another account'
      elsif User.where("phone = ? ", params[:user][:phone]).exists?
        return already_exist_error 'Phone number is already used with another account'
      end
    else
      bad_request_error("Missing required parameters", 400)
    end
  end

  def validate_sign_in_params
    if params[:user][:email].present? && params[:user][:phone].present?
      @resource = User.email_or_phone_exist?(params[:user][:email], params[:user][:phone]).first
      bad_request_error("User not found", 404) and return unless @resource.present?
    else
      bad_request_error("Missing required parameters", 400)
    end
  end

  def validate_account_update_request
    if params[:user][:phone].present?
      users = User.where.not(id: current_user.id)
      taken = users.where("phone = ? ", params[:user][:phone])
      return already_exist_error 'phone number is already used with another account' if !taken.nil?
    end
  end

  def already_exist_error(error)
    render json: {
      success: false,
      message: error
    }, status: 422
  end

  def user_already_exist?
    user = User.email_or_phone_exist?(params[:user][:email], params[:user][:phone]).first
    true if user.present?
  end

  def bad_request_error(message, status)
    render json: {
        success: false,
        message: message,
    }, status: status
  end

  def render_sucessfull_message(message, status)
    render json: {
        success: true,
        message: message,
    }, status: status
  end

end
