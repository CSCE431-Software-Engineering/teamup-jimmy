# frozen_string_literal: true

class LandingController < ApplicationController
  skip_before_action :authenticate_account!, only: [:index]
  def index; end

  def new; end
end
