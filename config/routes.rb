Rails.application.routes.draw do
  # NOTHING HERE RIGHT NOW root ''
  
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
