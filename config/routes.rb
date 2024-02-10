Rails.application.routes.draw do
  root "landing#index"

  resources :landing
  resources :students, except: :show;
  get 'students/basic'
  get 'students/index'
  get 'pages/home'
  get 'pages/match'
  get 'pages/profile'


  # resources :landing do
  #   member do
  #     get :delete
  #   end
  # end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
