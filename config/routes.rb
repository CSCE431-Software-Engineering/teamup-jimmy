Rails.application.routes.draw do
  root "landing#index"

  resources :landing
  resources :students
  get 'students/basic'
  get 'pages/home'
  get 'pages/match'

  # resources :landing do
  #   member do
  #     get :delete
  #   end
  # end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
