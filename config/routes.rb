Rails.application.routes.draw do
  root "landing#index"

  resources :landing, except: :show
  resources :students, except: :show;
  get 'students/basic'
  get 'students/index'
  get 'pages/home'
  get 'pages/match'
  get 'pages/profile'
  get 'students/:id', to: 'students#show', constraints: { id: /[^\/]+/ }



  # resources :landing do
  #   member do
  #     get :delete
  #   end
  # end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
