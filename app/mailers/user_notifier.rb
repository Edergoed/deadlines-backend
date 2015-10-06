class UserNotifier < ActionMailer::Base
      default :from => 'no-reply@goededesigns.com'

        # send a signup email to the user, pass in the user object that   contains the user's email address
      def send_signup_email(user, activation_token)
          @user = user
          @activation_token = activation_token
          mail( :to => @user.email,
               :subject => 'Thanks for signing up for Deadlines' )
      end
end
