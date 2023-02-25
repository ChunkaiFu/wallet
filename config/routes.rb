Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root                'sessions#home'
  get    'help'    => 'static_pages#help'
  get    'About'   => 'static_pages#about'
  get    'Contact Us' => 'static_pages#contact'
  get    '/Register'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  resources :users
end
