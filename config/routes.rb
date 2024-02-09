Rails.application.routes.draw do
  root "landing#index"

  get 'landing/index'
  get 'landing/signup'

  # resources :landing do
  #   member do
  #     get :delete
  #   end
  # end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
