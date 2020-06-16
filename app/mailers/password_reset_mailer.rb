class PasswordResetMailer < ApplicationMailer
	
	def password_reset_token_email(user, token)
		@user = user
		@token = token
		mail(to: @user.email, subject: 'Password Reset')
	end

end
