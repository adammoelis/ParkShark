Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: "users/sessions" }

  root to: 'home#index'
  get 'spots/:id/reserve', to: 'reservations#reserve_spot', as: 'reserve_spot'
  post 'spots/:id/reserve', to: 'reservations#confirm_spot', as: 'confirm_spot'
  get 'home/about', to: 'home#about', as: 'about'
  get 'home/contact', to: 'home#contact', as: 'contact'
  get 'my_location', to: 'home#location', as:'my_location'
  post 'my_location', to: 'home#set_location', as:'set_location'
  get 'nearby-parking', to: 'search#nearby', as: 'nearby_spots'
  resources :transactions
  resources :messages
  resources :reviews
  resources :cars
  resources :spots
  resources :users do
    get 'spots', to: "users#user_spots"
  end
end
