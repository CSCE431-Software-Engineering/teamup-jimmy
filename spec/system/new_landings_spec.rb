require 'rails_helper'

RSpec.describe "NewLandings", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'check for a back button' do
    visit '/landing/new'

    expect(page).to have_content('Back')
  end

  it 'navigating back to previous default landing page' do
    visit '/landing/new'
    click_on 'Back'

    expect(page).to have_content('The TAMU Gym Buddy Matching App')
  end

  it 'navigating from new landing to create profile page' do
    visit '/landing/new'
    click_on 'Create A Profile'

    expect(page).to have_content('Let\'s get started!')
  end
end
