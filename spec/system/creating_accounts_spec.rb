
require 'rails_helper'
require 'date'

RSpec.describe 'CreatingAccounts', type: :system do
  before do
    driven_by(:rack_test)
  end

  def simulate_google_oauth2_sign_in
    visit '/accounts/auth/google_oauth2'
    visit account_google_oauth2_omniauth_callback_path
  end

  it 'Integrity Case 1 Sunny Day: successful profile creation, with sign-in through Google OAuth2' do
    visit '/accounts/auth/google_oauth2' 
    visit account_google_oauth2_omniauth_callback_path
    expect(page).to have_content('Account Creation')
  end

  # Other tests that don't require authentication remain unchanged
  it 'Unit test 1: check for a back button' do
    visit '/students/basic'
    expect(page).to have_content('Back')
  end

  it 'Unit test 2: navigating back to previous new student page' do
    visit '/students/basic'
    click_on 'Back'
    expect(page).to have_content('Let\'s get started!')
  end

  it 'Integrity Case 2 Sunny Day: successful profile creation, with basic tamu email' do
    simulate_google_oauth2_sign_in
    fill_in 'student_name', with: 'Cloud Strife'
    select 'Male', from: 'student_gender'
    fill_in 'student_birthday', with: '1986-08-11'
    click_on 'Create Profile'
    expect(page).to have_content('You\'re signed in!')
  end


  it 'Integrity Case 2 Rainy Day 1: preventing empty name' do
    visit '/students/basic'
    fill_in 'student_name', with: ''
    select 'Male', from: 'student_gender'
    fill_in 'student_birthday', with: '1950-10-13'
    click_on 'Create Profile'
    expect(page).to have_content('There was a problem with your input. Please make sure to fill out every field.')
  end


  it 'Integrity Case 2 Rainy Day 3: preventing empty gender' do
    
    visit '/students/basic'
    fill_in 'student_name', with: 'Aerith Gainsborough'
    select 'Please select gender', from: 'student_gender'
    fill_in 'student_birthday', with: '1985-02-07'
    click_on 'Create Profile'
    expect(page).to have_content('There was a problem with your input. Please make sure to fill out every field.')
  end

  it 'Integrity Case 2 Rainy Day 4: preventing empty birthday' do
    
    visit '/students/basic'
    fill_in 'student_name', with: 'Tifa Lockhart'
    select 'Female', from: 'student_gender'
    fill_in 'student_birthday', with: ''
    click_on 'Create Profile'
    expect(page).to have_content('There was a problem with your input. Please make sure to fill out every field.')
  end

  it 'Integrity Case 2 Rainy Day 5: test all empty' do
    visit '/students/basic'
    click_on 'Create Profile'
    expect(page).to have_content('There was a problem with your input. Please make sure to fill out every field.')
  end
end

  
