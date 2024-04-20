# frozen_string_literal: true

# spec/features/edit_privacy_settings_spec.rb
require 'rails_helper'

RSpec.feature 'EditPrivacySettings', type: :feature do
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
    visit '/students/edit_is_private'
  end

  scenario 'Sunny: Successfully sets account to private' do
    choose 'is_private_true' # This will look for an element with id 'is_private_true'
    click_button 'Save'
    expect(page).to have_content('Workout Partner Preferences')
  end

  scenario 'Sunny: Successfully sets account to public' do
    choose 'is_private_false' # This will look for an element with id 'is_private_false'
    click_button 'Save'
    expect(page).to have_content('Workout Partner Preferences')
  end

  scenario 'Rainy: Form submission successful when no option is selected' do
    click_button 'Save'
    expect(page).to have_content('Workout Partner Preferences')
  end

  scenario 'Rainy: Clicking back button without selecting returns to the previous page' do
    click_link 'Back'
    expect(page).to have_current_path(students_personal_info_path)
  end
end
