class Accounts::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :confirm_authenticated_account
  
  def google_oauth2
    account = Account.from_google(**from_google_params)
  
    if account.present?
      sign_out_all_scopes
      flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect_existing_or_new_account(account)
    else
      flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
      redirect_to root_path
    end
  end
  
  private
  
  def sign_in_and_redirect_existing_or_new_account(account)
    
    if account.persisted?
      
      # Try to find the student associated with the account by email
      student_email_prefix = account.email.split('@').first
      session[:student_id] = student_email_prefix
      session[:reinit_match_score] = true
      student = Student.find_by(email: student_email_prefix)
      if student.present?
        # If a student entity exists, set the session and redirect to the students index
        redirect_to students_index_path
      else
        # If a student entity does not exist, create one
        session[:student_id] = student_email_prefix
        redirect_to students_basic_path
      end
    else
      # If the account is new, sign in and redirect to the path for new accounts
      sign_in account, event: :authentication
      redirect_to after_sign_in_path_for(account)
    end
  end
  
  protected
  
  def after_omniauth_failure_path_for(_scope)
    puts "Failed to authenticate with Google"
    root_path
  end
  
  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || student_new_path
  end
  
  private
  
  def from_google_params
    @from_google_params ||= {
      uid: auth.uid,
      email: auth.info.email,
      full_name: auth.info.name,
      avatar_url: auth.info.image
    }
  end
  
  def auth
    @auth ||= request.env['omniauth.auth']
  end
end