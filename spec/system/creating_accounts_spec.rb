require 'rails_helper'

RSpec.describe "CreatingAccounts", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'check for a back button' do
    visit '/students/basic'

    expect(page).to have_content('Back')
  end

  it 'navigating back to previous new student page' do
    visit '/students/basic'
    click_on 'Back'

    expect(page).to have_content('Let\'s get started!')
  end

  it 'preventing empty name' do
    visit '/students/basic'
    fill_in 'Name', with: ''
    fill_in 'Email', with: 'vincentvalentine@tamu.edu'
    select 'Male', from: 'Gender Identification Preference'
    fill_in 'Select Your Birthday', with '10/13/1950'
    click_on 'Create Profile'

    expect(page).to have_content('Input cannot be blank')
  end

  it 'preventing empty email' do
    visit '/students/basic'
    fill_in 'Name', with: 'Barret Wallace'
    fill_in 'Email', with: ''
    select 'Male', with: 'Gender Identification Preference'
    fill_in 'Select Your Birthday', with '12/15/1972'
    click_on 'Create Profile'

    expect(page).to have_content('Input cannot be blank')
  end

  it 'preventing empty gender' do
    visit '/students/basic'
    fill_in 'Name', with: 'Aerith Gainsborough'
    fill_in 'Email', with: 'aerithgainsborough@tamu.edu'
    select 'Please select gender', with: 'Gender Identification Preference'
    fill_in 'Select Your Birthday', with '02/07/1985'
    click_on 'Create Profile'

    expect(page).to have_content('Input cannot be blank')
  end

  it 'preventing empty birthday' do
    visit '/students/basic'
    fill_in 'Name', with: 'Tifa Lockhart'
    fill_in 'Email', with: 'tifalockhard@tamu.edu'
    select 'Female', with: 'Gender Identification Preference'
    fill_in 'Select Your Birthday', with ''
    click_on 'Create Profile'

    expect(page).to have_content('Input cannot be blank')
  end

  it 'test all empty' do
    visit '/students/basic'
    click_on 'Create Profile'

    expect(page).to have_content('Input cannot be blank')
  end

  it 'test successful profile creation' do
    visit '/students/basic'
    fill_in 'Name', with: 'Cloud Strife'
    fill_in 'Email', with: 'cloudstrife@tamu.edu'
    select 'Male', from: 'Gender Identification Preference'
    fill_in 'Select Your Birthday', with: '08/11/1986'
    click_on 'Create Profile'

    expect(page).to have_content('You\'re signed in!')
  end
end
