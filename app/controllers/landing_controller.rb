# frozen_string_literal: true

class LandingController < ApplicationController
  skip_before_action :confirm_authenticated_account
  def index; end

  def new; end
end
