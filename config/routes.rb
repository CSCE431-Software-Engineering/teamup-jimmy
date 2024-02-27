# frozen_string_literal: true

Rails.application.routes.draw do
  root 'landing#index'

  resources :landing, except: :show
  resources :students, except: :show
  resources :activities, except: :show
  resources :activity_preferences, only: [:index, :destroy, :new]
  resources :time_preferences, only: [:index, :edit, :new]
 

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

  patch 'students/update2_name', to: 'students#update2_name', as: 'update2_name_student'



  get 'students/connect_socials'
  get 'students/workoutPref'

  get 'customization/personalPref'
  get 'customization/socialMedia'
  get 'customization/workoutPref'

  get 'pages/home'
  get 'pages/match'
  get 'pages/profile'

  get 'time_preferences/edit'

  resources :activity_preferences do
    get 'experience', on: :member
    post 'experience', on: :member
  end
  
  # resources :activity_preferences do
  #   get 'experience', on: :member
  # end
  
  get 'students/:id', to: 'students#show', constraints: { id: %r{[^/]+} }

  # resources :landing do
  #   member do
  #     get :delete
  #   end
  # end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
