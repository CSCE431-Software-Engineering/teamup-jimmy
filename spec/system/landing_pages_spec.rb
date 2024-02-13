require 'rails_helper'

RSpec.describe "LandingPages", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'check load for landing page' do
    visit '/'

    expect(page).to have_content('Jimmy')
  end

  it 'check for copyright footer' do
    visit '/'

    expect(page).to have_content('Teamup is a 501(c)(3) nonprofit organization.')
  end

  it 'navigating from landing page to log in / sign up' do
    visit '/'
    click_on 'Log in / Sign up'

    expect(page).to have_content('Seems like you\'re new to Jimmy...')
  end
end
