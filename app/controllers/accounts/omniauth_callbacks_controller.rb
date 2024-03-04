class Accounts::OmniauthCallbacksController < Devise::OmniauthCallbacksController
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
      redirect_to student_index_path
    else
      redirect_to student_new_path
    end
  end
  
  protected
  
  def after_omniauth_failure_path_for(_scope)
    new_account_session_path
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