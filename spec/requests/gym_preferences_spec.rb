require 'rails_helper'

RSpec.describe "GymPreferences", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/gym_preferences/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/gym_preferences/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
