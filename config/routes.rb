Rails.application.routes.draw do
  root 'dashboard#index'
  # QUESTION: Is this the best way to be able to set an actual /ADMIN page?
  get '/admin' => 'admin#index'
  namespace :admin do
  	resources :categories
  	resources :products
  	resources :users
  	resources :addresses
  	resources :credit_cards, only: [:destroy]
  end
end
