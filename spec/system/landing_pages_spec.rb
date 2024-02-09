require 'rails_helper'

RSpec.describe "LandingPages", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'check load for landing page' do
    visit '/landing/index'

    expect(page).to have_content('Jimmy')
  end
end
