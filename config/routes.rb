Rails.application.routes.draw do
  get "/", to: "home#index"
  resources :menuitems
  resources :users
  resources :menuitems
  resources :orders
  get "/signin", to: "sessions#new", as: :new_sessions
  post "/signin", to: "sessions#create", as: :sessions
  delete "/signout", to: "sessions#destroy", as: :destroy_session
end
