# frozen_string_literal: true

Rails.application.routes.draw do
  root 'landing#index'

  resources :landing, except: :show
  resources :students, except: :show, constraints: { id: /[^\/]+/ }

  resources :activities, except: :show
  resources :activity_preferences, only: [:index, :destroy, :new]
  resource :time_preferences, only: [:index, :edit, :new, :update]
  resources :gym_preferences, except: :show
  resources :matches, only: [:index, :pending, :matched, :blocked, :profile, :update]

  get '/logout', to: 'application#logout'


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
  get 'students/delete_confirmation'
  get 'students/setup_personal_info'
  get 'students/setup_workout_partner_preferences'
  get 'students/setup_activity_preferences'
  get 'students/setup_time_preferences'

  get 'students/start_matching'
  get '/start_matching', to: 'students#start_matching', as: 'start_matching'


  get 'students/matching_preferences'
  get 'students/edit_gender_pref'
  get 'students/edit_age_pref'

  get 'students/connect_socials'
  get 'students/edit_instagram_url'
  get 'students/edit_x_url'
  get 'students/edit_snap_url'
  
  get 'students/workout_preferences'

  get 'students/:id', to: 'students#show', constraints: { id: %r{[^/]+} }
  delete 'students/:id', to: 'students#destroy', as: 'destroy_student'

  get 'customization/personalPref'
  get 'customization/socialMedia'
  get 'customization/workoutPref'

  get 'pages/home'
  get 'pages/match'
  get 'pages/profile'

  ### paths added for browsig feature ####
  get 'pages/browse'
  get '/search_users', to: 'pages#search', as: 'search_users'

  get 'time_preferences/index'
  get 'time_preferences/edit'

  get 'gym_preferences/edit'
  
  get 'matches/pending'
  get 'matches/incoming'
  get 'matches/matched'
  get 'matches/blocked'
  get 'matches/profile'

  get 'matches/:id', to: 'matches#profile', constraints: { id: %r{[^/]+} }

  resources :activity_preferences do
    get 'experience', on: :member
    post 'experience', on: :member
  end

  # resources :matches do
  #   member do
  #     patch :update_relationship_enum
  #   end
  # end



  ######
  # Routes for handling omniauth callback and sign in/out
  devise_for :accounts, controllers: { omniauth_callbacks: 'accounts/omniauth_callbacks' }
  devise_scope :account do
    get 'accounts/sign_in', to: 'accounts/sessions#new', as: :new_account_session
    get 'accounts/sign_out', to: 'accounts/sessions#destroy', as: :destroy_account_session
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
