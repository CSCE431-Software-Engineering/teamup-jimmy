require 'rails_helper'
require 'date'

RSpec.describe "MatchingUsers", type: :system do
  let(:current_user) do
    Student.create!(
      name: 'Cloud Strife',
      email: 'cloud@example.com',
      gender: 'Male',
      birthday: '1986-08-11',
      is_private: false
    )
  end

  before do
    driven_by(:rack_test)

    def simulate_google_oauth2_sign_in
      visit '/accounts/auth/google_oauth2'
      visit account_google_oauth2_omniauth_callback_path
    end

    # Directly create records in the test database for other users
    Student.create!(
      name: 'Young',
      email: 'young@example.com',
      gender: 'Female',
      birthday: '2004-01-01',
      is_private: false
    )
    Student.create!(
      name: 'Old',
      email: 'old@example.com',
      gender: 'Male',
      birthday: '2000-12-31',
      is_private: false
    )
    Student.create!(
      name: 'Today',
      email: 'today@example.com',
      gender: 'Other',
      birthday: '2000-04-20',
      is_private: false
    )

    simulate_google_oauth2_sign_in
    visit '/students/basic'
    fill_in 'student_name', with: 'Cloud Strife'
    select 'Male', from: 'student_gender'
    fill_in 'student_birthday', with: '1986-08-11'
    click_on 'Next'
    click_on 'Skip'
    expect(page).to have_content('Home')

    # Simulate user profile creation for matching functionality
    simulate_google_oauth2_sign_in
    expect(page).to have_content('Home')
    visit '/pages/match'
  end

  describe '#calculate_birthday_age' do
    it 'calculates birthday age for birthday before current date' do
      user = Student.find_by(name: 'Young')
      matching_service = MatchingService.new(current_user)

      allow(Date).to receive(:today).and_return(Date.new(2024, 4, 20)) # Stub today's date to April 20, 2024
      age = matching_service.calculate_birthday_age(user)

      expect(age).to eq(20)
    end

    it 'calculates birthday age for birthday after current date' do
      user = Student.find_by(name: 'Old')
      matching_service = MatchingService.new(current_user)

      allow(Date).to receive(:today).and_return(Date.new(2024, 4, 20)) # Stub today's date to April 20, 2024
      age = matching_service.calculate_birthday_age(user)

      expect(age).to eq(23)
    end

    it 'calculates birthday age for birthday on current date' do
      user = Student.find_by(name: 'Today')
      matching_service = MatchingService.new(current_user)

      allow(Date).to receive(:today).and_return(Date.new(2024, 4, 20)) # Stub today's date to April 20, 2024
      age = matching_service.calculate_birthday_age(user)

      expect(age).to eq(24)
    end
  end  
end
