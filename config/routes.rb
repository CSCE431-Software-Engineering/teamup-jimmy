# frozen_string_literal: true

Rails.application.routes.draw do
  root 'landing#index'

  resources :landing, except: :show
  resources :students, except: :show
  get 'students/basic'
  get 'students/index'
  get 'students/settings'
  get 'students/workoutPref'

  get 'pages/home'
  get 'pages/match'
  get 'pages/profile'

  get 'activities/index'

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
