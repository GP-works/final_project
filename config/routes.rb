Rails.application.routes.draw do
  get "/", to: "home#index"
  get "/orders/bill", to: "orders#bill", as: :bill
  post "/orders/pay", to: "orders#pay"
  resources :menus
  resources :users
  resources :menuitems
  resources :orders

  post "/menus/setmenu", to: "menus#set", as: :setmenu
  get "/signin", to: "sessions#new", as: :new_sessions
  post "/signin", to: "sessions#create", as: :sessions
  delete "/signout", to: "sessions#destroy", as: :destroy_session
end
