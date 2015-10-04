class AdminNotifier < ApplicationMailer
	default :from => 'no-reply@goededesigns.com'

    # send a signup email to the user, pass in the user object that   contains the user's email address
    def send_signup_email(user)
        @user = user
        mail( :to => 'deadlines@goededesigns.com',
             :subject => 'New user' )
    end
end
