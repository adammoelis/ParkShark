Rails.application.routes.draw do

  devise_for :users

  root to: 'home#index'

  resources :transactions
  resources :messages
  resources :reviews
  resources :cars
  resources :spots
  resources :users do
    resources :spots
  end
end
