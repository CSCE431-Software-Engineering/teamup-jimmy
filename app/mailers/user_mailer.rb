# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
    default from: 'teamupjimmy@gmail.com'
  
    def match_notification(user, match_user)
      @user = user
      @match_user = match_user

      user_email = format_email(@user.email)
      match_user_email = format_email(@match_user.email)
  
      mail(to: user_email, subject: 'You have a new match on Jimmy!')
    end

    def match_request_notification(user, match)
  
        user_email = format_email(user)
        match_user_email = format_email(match)
    
        mail(to: match_user_email, subject: 'You have a new match request on Jimmy!')
      end
  
    private
  
    def format_email(email)
      email.end_with?('@tamu.edu') ? email : "#{email}@tamu.edu"
    end

  end
  