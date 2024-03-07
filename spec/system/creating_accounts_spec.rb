# frozen_string_literal: true

require 'rails_helper'
require 'date'

RSpec.describe 'CreatingAccounts', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'Unit: check for a back button' do
    visit '/students/basic'

    expect(page).to have_content('Back')
  end

  it 'Unit: navigating back to previous new student page' do
    visit '/students/basic'
    click_on 'Back'

    expect(page).to have_content('Let\'s get started!')
  end

  it 'Integrity Case 1 Sunny Day: successful profile creation, with basic tamu email' do
    visit '/students/basic'
    fill_in 'student_name', with: 'Cloud Strife'
    fill_in 'student_email', with: 'cloudstrife@tamu.edu'
    select 'Male', from: 'student_gender'
    fill_in 'student_birthday', with: '1986-08-11'
    click_on 'Create Profile'

    expect(page).to have_content('You\'re signed in!')
  end

  it 'Integrity Case 1 Rainy Day 1: unsuccessful profile creation, with invalid tamu email' do
    visit '/students/basic'
    fill_in 'student_name', with: 'Cloud Strife'
    fill_in 'student_email', with: '@tamu.edu'
    select 'Male', from: 'student_gender'
    fill_in 'student_birthday', with: '1986-08-11'
    click_on 'Create Profile'

    expect(page).to have_content('Email is not a valid TAMU email address.')
  end

  it 'Integrity Case 1 Rainy Day 2: unsuccessful profile creation, with non-tamu email' do
    visit '/students/basic'
    fill_in 'student_name', with: 'Cid Highwind'
    fill_in 'student_email', with: 'cidhighwind@yahoo.com'
    select 'Male', from: 'student_gender'
    fill_in 'student_birthday', with: '1975-02-22'
    click_on 'Create Profile'

    expect(page).to have_content('Email is not a valid TAMU email address.')
  end

    it 'Integrity Case 2 Sunny Day: successful profile creation, with basic tamu email' do
      visit '/students/basic'
      fill_in 'student_name', with: 'Cloud Strife'
      fill_in 'student_email', with: 'cloudstrife@tamu.edu'
      select 'Male', from: 'student_gender'
      fill_in 'student_birthday', with: '1986-08-11'
      click_on 'Create Profile'
  
      expect(page).to have_content('You\'re signed in!')
    end

    it 'Integrity Case 2 Rainy Day 1: preventing empty name' do
      visit '/students/basic'
      fill_in 'student_name', with: ''
      fill_in 'student_email', with: 'vincentvalentine@tamu.edu'
      select 'Male', from: 'student_gender'
      fill_in 'student_birthday', with: '1950-10-13'
      click_on 'Create Profile'
  
      expect(page).to have_content('There was a problem with your input. Please make sure to fill out every field.')
    end
  
    it 'Integrity Case 2 Rainy Day 2: preventing empty email' do
      visit '/students/basic'
      fill_in 'student_name', with: 'Barret Wallace'
      fill_in 'student_email', with: ''
      select 'Male', from: 'student_gender'
      fill_in 'student_birthday', with: '1972-12-15'
      click_on 'Create Profile'
  
      expect(page).to have_content('Email is not a valid TAMU email address.')
    end
  
    it 'Integrity Case 2 Rainy Day 3: preventing empty gender' do
      visit '/students/basic'
      fill_in 'student_name', with: 'Aerith Gainsborough'
      fill_in 'student_email', with: 'aerithgainsborough@tamu.edu'
      select 'Please select gender', from: 'student_gender'
      fill_in 'student_birthday', with: '1985-02-07'
      click_on 'Create Profile'
  
      expect(page).to have_content('There was a problem with your input. Please make sure to fill out every field.')
    end
  
    it 'Integrity Case 2 Rainy Day 4: preventing empty birthday' do
      visit '/students/basic'
      fill_in 'student_name', with: 'Tifa Lockhart'
      fill_in 'student_email', with: 'tifalockhard@tamu.edu'
      select 'Female', from: 'student_gender'
      fill_in 'student_birthday', with: ''
      click_on 'Create Profile'
  
      expect(page).to have_content('There was a problem with your input. Please make sure to fill out every field.')
    end
  
    it 'Integrity Case 2 Rainy Day 5: test all empty' do
      visit '/students/basic'
      click_on 'Create Profile'
      expect(page).to have_content('Email is not a valid TAMU email address.')
    end
end
