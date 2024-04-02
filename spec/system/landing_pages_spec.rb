# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'LandingPages', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'Integrity Test: Preventing Viewing other users pages' do
    visit 'students/kieranbeirne'

    expect(page).to have_content('Jimmy')
  end

  it 'Usability Test: Check for footer' do
    visit '/'

    expect(page).to have_content('Teamup is a 501(c)(3) nonprofit organization.')
  end

  it 'Usability Test: Login Button' do
    visit '/'
    click_on 'Log in / Sign up'

    expect(page).to have_content('Please select gender Male Female Other Select Your Birthday Enter Your Phone Number')
  end
end
