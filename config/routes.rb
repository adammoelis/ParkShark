Rails.application.routes.draw do
  resources :transactions
  resources :messages
  resources :reviews
  resources :cars
  resources :spots
  resources :users
end
