Rails.application.routes.draw do
  root 'dashboard#index'
  
  resources :dashboard, only: [:index]

  get '/admin' => 'admin/dashboard#index'
  
  namespace :admin do
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
