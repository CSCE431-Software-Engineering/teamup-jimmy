# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CreateBrowseQuery', type: :system do
  before do
    driven_by(:rack_test)

    def simulate_google_oauth2_sign_in
      visit '/accounts/auth/google_oauth2'
      visit account_google_oauth2_omniauth_callback_path
    end

    # Directly create records in the test database
    Student.create!(
      name: 'kb testing',
      email: 'kb@example.com',
      gender: 'Other', # Set the correct gender if needed
      birthday: '2000-01-01', # Adjust the date as necessary
      is_private: 'false'
    )
    Student.create!(
      name: 'Firsy Lasy',
      email: 'firsyl@example.com',
      gender: 'Male',
      birthday: '2000-01-01',
      is_private: 'false'
    )
    Student.create!(
      name: 'Lily Tang',
      email: 'lilyt@example.com',
      gender: 'Female',
      birthday: '2000-01-01',
      is_private: 'false'
    )

    simulate_google_oauth2_sign_in
    visit '/students/basic'
    fill_in 'student_name', with: 'Cloud Strife'
    select 'Male', from: 'student_gender'
    fill_in 'student_birthday', with: '1986-08-11'
    click_on 'Next'
    click_on 'Skip'
    expect(page).to have_content('Home')

    # Simulate user profile creation for search functionality
    simulate_google_oauth2_sign_in
    expect(page).to have_content('Home')
    visit '/pages/browse'
  end

  it 'Sunny: Can search for users with no gender filter' do
    fill_in 'search-input', with: 'K'
    click_button 'Search'
    expect(page).to have_content('kb testing')
    expect(page).not_to have_content('Barret Wallace')
  end

  it 'Sunny: Can search for male users' do
    fill_in 'search-input', with: 'L'
    check 'male'
    click_button 'Search'
    expect(page).to have_content('Firsy Lasy')
  end

  it 'Sunny: Can search for female users' do
    fill_in 'search-input', with: 'L'
    check 'female'
    click_button 'Search'
    expect(page).to have_content('Lily Tang')
  end

  it 'Rainy: Displays "No results found" for a search with no matches' do
    fill_in 'search-input', with: 'Z'
    click_button 'Search'
    expect(page).to have_content('No results found for "Z"')
  end

  # Helper methods
  def simulate_google_oauth2_sign_in
    # Your sign-in simulation logic here
    visit '/accounts/auth/google_oauth2'
    visit account_google_oauth2_omniauth_callback_path
  end
end
