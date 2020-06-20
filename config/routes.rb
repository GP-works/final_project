Rails.application.routes.draw do
  get "/", to: "home#index"
  patch "/orders/pay", to: "orders#pay"
  post "/orders/addmore", to: "orders#addmore"
  get "/orders/cart", to: "orders#cart", as: :cart
  post "/orders/:id", to: "orders#reorder", as: :reorder
  get "/menus/edit", to: "menus#edit", as: :menus_edit
  resources :menus
  resources :users
  resources :menuitems
  resources :orders
  resources :orderitems
  resources :submenus
  resources :reports
  post "/menus/setmenu", to: "menus#set", as: :setmenu
  get "/signin", to: "sessions#new", as: :new_sessions
  post "/signin", to: "sessions#create", as: :sessions
  delete "/signout", to: "sessions#destroy", as: :destroy_session
  put "/menuitems/available/:id", to: "menuitems#available", as: :available_path
  put "/users/change_role/:id", to: "users#change_role", as: :change_role
  put "/users/role_request/:id", to: "users#role_request", as: :role_request
end
