Rails.application.routes.draw do
  root "landing#index"

  resources :landing, except: :show
  resources :students, except: :show;
  get 'students/basic'
  get 'students/index'
  get 'pages/home'
  get 'pages/match'
  get 'pages/profile'

  devise_for :accounts, controllers: { omniauth_callbacks: 'accounts/omniauth_callbacks' }
  devise_scope :account do
    get 'accounts/sign_in', to: 'accounts/sessions#new', as: :new_account_session
    get 'accounts/sign_out', to: 'accounts/sessions#destroy', as: :destroy_account_session
  end


  # resources :landing do
  #   member do
  #     get :delete
  #   end
  # end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
