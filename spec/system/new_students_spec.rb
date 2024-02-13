require 'rails_helper'

RSpec.describe "NewStudents", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'check for a back button' do
    visit '/students/new'

    expect(page).to have_content('Back')
  end

  it 'navigating back to previous new landing page' do
    visit '/students/new'
    click_on 'Back'

    expect(page).to have_content('Create A Profile')
  end

  it 'navigating from new student to account creation page' do
    visit '/students/new'
    click_on 'Fill out only the basic information'

    expect(page).to have_content('Account Creation')
  end
end
