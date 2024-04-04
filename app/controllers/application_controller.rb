# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # before_action :confirm_authenticated_account
  before_action :authenticate_account!
  before_action :set_initialization_false

  def logout
    session[:student_id] = nil
    sign_out current_account
    redirect_to root_path
  end

  def confirm_authenticated_account
    if session[:student_id].nil?
      redirect_to root_path
    end
  end

  def set_initialization_false
    session[:render_account_creation_nav] = false
  end
end
