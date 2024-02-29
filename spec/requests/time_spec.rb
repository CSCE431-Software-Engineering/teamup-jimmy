require 'rails_helper'

RSpec.describe "Times", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/time/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/time/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/time/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
