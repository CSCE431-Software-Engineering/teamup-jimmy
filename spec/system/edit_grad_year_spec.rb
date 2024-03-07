# spec/features/edit_grad_year_spec.rb
require 'rails_helper'

RSpec.feature "EditGradYear", type: :feature do
  before do
    # Create student profile
    visit '/students/basic'
    fill_in 'student_name', with: 'Cloud Strife'
    fill_in 'student_email', with: 'cloudstrife@tamu.edu'
    select 'Male', from: 'student_gender'
    fill_in 'student_birthday', with: '1986-08-11'
    click_on 'Create Profile'

    expect(page).to have_content('You\'re signed in!')
    visit '/students/edit_grad_year' # Adjust the URL as necessary
  end

  scenario 'Successfully updates graduation year with valid input' do
    fill_in '2023', with: '2024'
    click_button 'Save'
    expect(page).to have_content('Your account was successfully updated.') 
  end

  scenario 'Allows to update graduation year with an empty field' do
    fill_in '2023', with: ''
    click_button 'Save'
    expect(page).to have_content('Your account was successfully updated.') 
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
