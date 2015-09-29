Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: "users/sessions" }

  root to: 'home#index'

  resources :transactions
  resources :messages
  resources :reviews
  resources :cars
  resources :spots
  resources :users do
    get 'spots', to: "users#user_spots"
  end
end
