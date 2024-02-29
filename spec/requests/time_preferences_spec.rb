require 'rails_helper'

RSpec.describe "TimePreferences", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/time_preferences/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/time_preferences/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/time_preferences/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
