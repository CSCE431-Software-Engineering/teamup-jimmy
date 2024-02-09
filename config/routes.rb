Rails.application.routes.draw do
  get 'pages/home'
  get 'pages/match'
  root "landing#index"

  get 'landing/index'
  get 'landing/new'
  get 'landing/home'

  # resources :landing do
  #   member do
  #     get :delete
  #   end
  # end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
