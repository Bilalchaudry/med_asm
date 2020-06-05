class PasswordResetJob < ApplicationJob
  queue_as :default

  def perform(user, token)
		PasswordResetMailer.password_reset_token_email(user, token).deliver_later
  end
end
