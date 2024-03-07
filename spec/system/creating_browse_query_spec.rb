RSpec.feature "CreateBrowseQuery", type: :feature do
    before do
      # Create student profile
      visit '/students/basic'
      fill_in 'student_name', with: 'Cloud Strife'
      fill_in 'student_email', with: 'cloudstrife@tamu.edu'
      select 'Male', from: 'student_gender'
      fill_in 'student_birthday', with: '1986-08-11'
      click_on 'Create Profile'
  
      expect(page).to have_content('You\'re signed in!')
      visit '/pages/browse'
    end

    scenario 'Sunny: Can search for users with no gender filter' do
        fill_in 'search-input', with: 'K'
        click_button 'Search'
        expect(page).to have_content('kb testing')
        expect(page).not_to have_content('Barret Wallace')
      end
    
      scenario 'Sunny: Can search for male users' do
        fill_in 'search-input', with: 'L'
        check 'male'
        click_button 'Search'
        expect(page).to have_content('Firsy Lasy')
      end
    
      scenario 'Sunny: Can search for female users' do
        fill_in 'search-input', with: 'L'
        check 'female'
        click_button 'Search'
        expect(page).to have_content('Lily Tang')
      end
    
      scenario 'Rainy: Displays "No results found" for a search with no matches' do
        fill_in 'search-input', with: 'Z'
        click_button 'Search'
        expect(page).to have_content('No results found for "Z"')
    end
end