# frozen_string_literal: true

Rails.application.routes.draw do
  root 'landing#index'

  resources :landing, except: :show
  resources :students, except: :show
  resources :activities, except: :show
  resources :activity_preferences, only: [:index, :destroy, :new]
  resources :time_preferences, only: [:index, :edit, :new]
  resources :gym_preferences, only: [:index, :edit]

  get 'students/basic'
  get 'students/index'
  get 'students/settings'
  get 'students/workoutPref'

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
