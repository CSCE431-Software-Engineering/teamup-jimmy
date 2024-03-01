# frozen_string_literal: true

Rails.application.routes.draw do
  root 'landing#index'

  resources :landing, except: :show
  resources :students, except: :show, constraints: { id: /[^\/]+/ }


  resources :activities, except: :show
  resources :activity_preferences, only: [:index, :destroy, :new]
  resources :time_preferences, only: [:index, :edit, :new]
  resources :gym_preferences, except: :show
  get 'students/basic'
  get 'students/index'
  get 'students/settings'

  get 'students/personal_info'
  get 'students/edit_name'
  get 'students/edit_gender'
  get 'students/edit_birthday'
  get 'students/edit_phone_number'
  get 'students/edit_major'
  get 'students/edit_grad_year'
  get 'students/edit_is_private'
  get 'students/edit_biography'

  get 'students/connect_socials'
  get 'students/workoutPref'

  get 'customization/personalPref'
  get 'customization/socialMedia'
  get 'customization/workoutPref'

  get 'pages/home'
  get 'pages/match'
  get 'pages/profile'

  get 'time_preferences/index'
  get 'time_preferences/edit'

  get 'gym_preferences/edit'
  


  resources :activity_preferences do
    get 'experience', on: :member
    post 'experience', on: :member
  end
  get 'students/:id', to: 'students#show', constraints: { id: %r{[^/]+} }


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
