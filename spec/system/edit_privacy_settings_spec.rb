# spec/features/edit_privacy_settings_spec.rb
require 'rails_helper'

RSpec.feature "EditPrivacySettings", type: :feature do
  before do
    # Create student profile
    visit '/students/basic'
    fill_in 'student_name', with: 'Cloud Strife'
    fill_in 'student_email', with: 'cloudstrife@tamu.edu'
    select 'Male', from: 'student_gender'
    fill_in 'student_birthday', with: '1986-08-11'
    click_on 'Create Profile'

    expect(page).to have_content('You\'re signed in!')
    visit '/students/edit_is_private'
  end

  scenario 'Sunny: Successfully sets account to private' do
    choose 'is_private_true' # This will look for an element with id 'is_private_true'
    click_button 'Save'
    expect(page).to have_content('Your account was successfully updated.')
  end

  scenario 'Sunny: Successfully sets account to public' do
    choose 'is_private_false' # This will look for an element with id 'is_private_false'
    click_button 'Save'
    expect(page).to have_content('Your account was successfully updated.')
  end

  scenario 'Rainy: Form submission successful when no option is selected' do
    click_button 'Save'
    expect(page).to have_content('Your account was successfully updated.') 
  end

  scenario 'Rainy: Clicking back button without selecting returns to the previous page' do
    click_link 'Back'
    expect(page).to have_current_path(students_personal_info_path)
  end
end
