# # spec/features/edit_account_spec.rb
# require 'rails_helper'

# RSpec.feature "EditPhoneNumber", type: :feature do
#   before do
#     # Create student profile
#     visit '/students/basic'
#     fill_in 'student_name', with: 'Cloud Strife'
#     fill_in 'student_email', with: 'cloudstrife@tamu.edu'
#     select 'Male', from: 'student_gender'
#     fill_in 'student_birthday', with: '1986-08-11'
#     click_on 'Create Profile'

#     expect(page).to have_content('You\'re signed in!')
#     visit '/students/edit_phone_number' # Adjust the URL as necessary
#   end

#   scenario 'Integrity Case 3 Sunny Day: Successfully updates phone number with valid input' do
#     fill_in 'Phone number', with: '1234567890'
#     click_button 'Save'
#     expect(page).to have_content('Your account was successfully updated.') # Adjust based on actual success message
#   end

#   scenario 'Integrity Case 3 Rainy Day 1: Fails to update phone number with too many digits' do
#     fill_in 'Phone number', with: '12345678900'
#     click_button 'Save'
#     expect(page).not_to have_content('Your account was successfully updated.') # Adjust based on actual error message
#   end

#   scenario 'Integrity Case 3 Rainy Day 2: Fails to update phone number with too few digits' do
#     fill_in 'Phone number', with: '123456789'
#     click_button 'Save'
#     expect(page).not_to have_content('Your account was successfully updated.') # Adjust based on actual error message
#   end

#   scenario 'Integrity Case 3 Rainy Day 3: Fails to update phone number with dashes' do
#     fill_in 'Phone number', with: '123-456-7890'
#     click_button 'Save'
#     expect(page).not_to have_content('Your account was successfully updated.') # Adjust based on actual error message
#   end

#   scenario 'Integrity Case 3 Rainy Day 4: Fails to update phone number with non-numeric input' do
#     fill_in 'Phone number', with: 'phonetest'
#     click_button 'Save'
#     expect(page).not_to have_content('Your account was successfully updated.') # Adjust based on actual error message
#   end
# end
