# frozen_string_literal: true

class ApplicationController < ActionController::Base
  #before_action :authenticate_account!

  def logout
    session[:student_id] = nil
    redirect_to root_path
  end
end
