Rails.application.routes.draw do
  get "about-us", to: "about#index", as: :about 

  get "contact", to: "contact#index", as: :contact 
  get "terms_of_services", to: "terms_of_services#index", as: :terms_of_services 

  get "password", to: "passwords#edit", as: :edit_password
  patch "password", to: "passwords#update"

  get "sign_up", to:  "registrations#new"
  post "sign_up", to: "registrations#create" 

  get "sign_in", to:  "sessions#new"
  post "sign_in", to: "sessions#create"

  delete "logout", to: "sessions#destroy"

  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"

  get "password/reset/edit", to: "password_resets#edit"
  patch "password/reset/edit", to: "password_resets#update"

  get "wallet/cards/new", to: "cards#new"
  post "wallet/cards/new", to: "cards#create"

  get "wallet/balances/new", to: "balances#new"
  post "wallet/balances/new", to: "balances#create"

  get "wallet/new", to:  "wallets#new" # and get for the new method 
  post "wallet/new", to: "wallets#create"
  
  patch "wallet/cards/:id", to: "cards#show" # patch for the update method in controller 
  post "wallet/cards/:id", to: "cards#show" # post for the create 

  patch "wallet/balances/:id", to: "balances#show" # patch for the update method in controller 
  post "wallet/balances/:id", to: "balances#show" # post for the create 

  get "wallet/balances/:id/edit", to: "balances#edit"
  patch "wallet/balances/:id/edit", to: "balances#update"

  
  resource :wallet do 
    resources :balances
    resources :cards 
  end 

  resource :user do
    resource :wallet
  end

  #root to: "main#index"
  root :to => redirect('/home')
  get '/home', to: 'main#index'

  get '/auth/:provider/callback', to: "sessions#omniauth"

  get "terms", to: "terms#edit"
  patch "terms", to: "terms#update"
  post "terms", to: "terms#create"
end