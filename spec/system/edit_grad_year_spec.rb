# frozen_string_literal: true

# spec/features/edit_grad_year_spec.rb
require 'rails_helper'

RSpec.feature 'EditGradYear', type: :feature do
  def simulate_google_oauth2_sign_in
    visit '/accounts/auth/google_oauth2'
    visit account_google_oauth2_omniauth_callback_path
  end
  before do
    # Create student profile
    simulate_google_oauth2_sign_in
    visit '/students/basic'
    fill_in 'student_name', with: 'Cloud Strife'
    select 'Male', from: 'student_gender'
    fill_in 'student_birthday', with: '1986-08-11'
    click_on 'Next'
    click_on 'Skip'
    expect(page).to have_content('Home')
    visit '/students/edit_grad_year' # Adjust the URL as necessary
  end

  scenario 'Successfully updates graduation year with valid input' do # allow user to proceed to next preference screen
    fill_in '2023', with: '2024'
    click_button 'Save'
    expect(page).to have_content('Workout Partner Preferences')
  end

  scenario 'Allows to update graduation year with an empty field' do # allow user to proceed to next preference screen
    fill_in '2023', with: ''
    click_button 'Save'
    expect(page).to have_content('Workout Partner Preferences')
  end

  scenario 'Fails to update graduation year with a year too far in the past' do
    fill_in '2023', with: '934'
    click_button 'Save'
    expect(page).not_to have_content('Your account was successfully updated.')
  end

  scenario 'Fails to update graduation year with a year too far in the future' do
    fill_in '2023', with: '20350'
    click_button 'Save'
    expect(page).not_to have_content('Your account was successfully updated.')
  end

  scenario 'Fails to update graduation year with non-numeric input' do
    fill_in '2023', with: 'year'
    click_button 'Save'
    expect(page).not_to have_content('Your account was successfully updated.')
  end
end
