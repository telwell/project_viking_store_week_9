Rails.application.routes.draw do
  # Set the root to the main dashboard
  root 'dashboard#index'
  
  # Make sure admin goes to the admin dashbaord
  get '/admin' => 'admin/dashboard#index'

  
  # Main dashboard only has index for now.
  resources :dashboard, only: [:index]
  resources :addresses, only: [:create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resource :user, only: [:new, :create, :edit, :update, :destroy]
  resource :cart
  resource :orders, only: [:edit, :update]

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
