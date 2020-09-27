module UsersHelper

  def password_reset(user)
    @user = user
    @token = Devise.friendly_token.first(8).upcase
    user.update(reset_password_token: @token)
    PasswordResetJob.perform_later(user, @token)
  end
end