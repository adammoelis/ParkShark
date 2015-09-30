Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: "users/sessions" }

  root to: 'home#index'
  get 'home/about', to: 'home#about', as: 'about'
  get 'home/contact', to: 'home#contact', as: 'contact'

  resources :transactions
  resources :messages
  resources :reviews
  resources :cars
  resources :spots
  resources :users do
    get 'spots', to: "users#user_spots"
  end
end
