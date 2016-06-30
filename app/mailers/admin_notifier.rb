class AdminNotifier < ApplicationMailer
	default :from => 'admin@deadlinesapp.io'

    # send a signup email to the user, pass in the user object that   contains the user's email address
    def send_newuser(user)
        @user = user
        mail( :to => 'bobbie.goede@gmail.com, liam.ederzeel@gmail.com',
             :subject => 'New user' )
    end
end
