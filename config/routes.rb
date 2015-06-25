Rails.application.routes.draw do
  root 'dashboard#index'
  get '/admin' => 'admin#index'
  namespace :admin do
  	resources :categories
  	resources :products
  end
end
