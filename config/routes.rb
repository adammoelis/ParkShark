Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: { sessions: "users/sessions", registrations: 'users/registrations', omniauth_callbacks: "omniauth_callbacks" }

  resources :purchases

  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      post :restore
      post :mark_as_read
    end
    collection do
      delete :empty_trash
    end
  end
  resources :messages, only: [:new, :create]

  get 'spots/:id/reserve', to: 'reservations#reserve_spot', as: 'reserve_spot'
  post 'purchases/checkout', to: 'purchases#checkout', as: 'checkout'
  post 'spots/:id/listings/:id/reserve', to: 'reservations#confirm_spot', as: 'confirm_spot'

  get 'about', to: 'home#about', as: 'about'
  get 'contact', to: 'home#contact', as: 'contact'
  get 'my_location', to: 'home#location', as:'my_location'
  post 'my_location', to: 'home#set_location', as:'set_location'
  get 'nearby-parking', to: 'search#nearby', as: 'nearby_spots'
  get 'find-a-spot', to: 'search#available_now', as: 'available_now'
  post 'find-a-spot', to: 'search#available_now_query'
  get 'users/purchase_information/:id', to: 'users#purchase_information', as: 'purchase_information'
  patch 'users/update_purchase_information/:id', to: 'users#update_purchase_information', as: 'update_purchase_information'
  post 'create_map', to: 'search#create_map'
  resources :reservations
  resources :transactions
  resources :reviews
  resources :cars
  resources :spots do
    resources :listings do
      resources :reservations
    end
  end
  resources :users do
    get 'spots', to: "users#user_spots"
  end
end
