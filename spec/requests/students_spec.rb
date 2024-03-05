# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Students', type: :request do
  # describe "GET /index" do
  #   it "returns http success" do
  #     get "/students/index"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe 'GET /new' do
    it 'returns http success' do
      get '/students/new'
      expect(response).to have_http_status(:success)
    end
  end
end
