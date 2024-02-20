require 'rails_helper'

RSpec.describe "Customizations", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/customization/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /personalInfo" do
    it "returns http success" do
      get "/customization/personalInfo"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /personalPref" do
    it "returns http success" do
      get "/customization/personalPref"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /workoutPref" do
    it "returns http success" do
      get "/customization/workoutPref"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /socialMedia" do
    it "returns http success" do
      get "/customization/socialMedia"
      expect(response).to have_http_status(:success)
    end
  end

end
