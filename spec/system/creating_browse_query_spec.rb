# RSpec.feature "CreateBrowseQuery", type: :feature do
#     before do
#         # Directly create records in the test database
#         Student.create!(
#           name: 'kb testing',
#           email: 'kb@example.com',
#           gender: 'Other', # Set the correct gender if needed
#           birthday: '2000-01-01', # Adjust the date as necessary
#           is_private: 'false'
#         )
#         Student.create!(
#           name: 'Firsy Lasy',
#           email: 'firsyl@example.com',
#           gender: 'Male',
#           birthday: '2000-01-01',
#           is_private: 'false'

#         )
#         Student.create!(
#           name: 'Lily Tang',
#           email: 'lilyt@example.com',
#           gender: 'Female',
#           birthday: '2000-01-01',
#           is_private: 'false'
#         )
    
#         # Create a user to perform the search
#         visit '/students/basic'
#         fill_in 'student_name', with: 'Cloud Strife'
#         fill_in 'student_email', with: 'cloudstrife@tamu.edu'
#         select 'Male', from: 'student_gender'
#         fill_in 'student_birthday', with: '1986-08-11'
#         click_on 'Create Profile'
    
#         expect(page).to have_content('You\'re signed in!')
#         visit '/pages/browse'
#       end

#     scenario 'Sunny: Can search for users with no gender filter' do
#         fill_in 'search-input', with: 'K'
#         click_button 'Search'
#         expect(page).to have_content('kb testing')
#         expect(page).not_to have_content('Barret Wallace')
#       end
    
#       scenario 'Sunny: Can search for male users' do
#         fill_in 'search-input', with: 'L'
#         check 'male'
#         click_button 'Search'
#         expect(page).to have_content('Firsy Lasy')
#       end
    
#       scenario 'Sunny: Can search for female users' do
#         fill_in 'search-input', with: 'L'
#         check 'female'
#         click_button 'Search'
#         expect(page).to have_content('Lily Tang')
#       end
    
#       scenario 'Rainy: Displays "No results found" for a search with no matches' do
#         fill_in 'search-input', with: 'Z'
#         click_button 'Search'
#         expect(page).to have_content('No results found for "Z"')
#     end
# end