Rails.application.routes.draw do
  # Set the root to the main dashboard
  root 'dashboard#index'
  
  # Make sure admin goes to the admin dashbaord
  get '/admin' => 'admin/dashboard#index'

  
  # Main dashboard only has index for now.
  resources :dashboard, only: [:index]
  resources :addresses, only: [:create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resource :user, only: [:new, :create]

  # QUESTION: Would this be singular? There's only one cart at a time
  # like there is in :session above? Let's play this out...
  resource :cart, only: [:index, :new, :create, :update, :destroy, :edit]

  namespace :admin do
    # Admin dashboard, only using index for now.
    resources :dashboard, only: [:index]
  	resources :categories
  	resources :products
  	resources :users
  	resources :addresses
    resources :orders
  	resources :credit_cards, only: [:destroy]
    resources :order_contents, only: [:update, :destroy, :create]
  end
end
