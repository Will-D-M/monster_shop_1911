Rails.application.routes.draw do

  get '/', to: "welcome#show"

  get "/merchants", to: "merchants#index"
  get "/merchants/new", to: "merchants#new"
  get "/merchants/:id", to: "merchants#show"
  post "/merchants", to: "merchants#create"
  get "/merchants/:id/edit", to: "merchants#edit"
  patch "/merchants/:id", to: "merchants#update"
  delete "/merchants/:id", to: "merchants#destroy"

  get "/items", to: "items#index"
  get "/items/:id", to: "items#show"
  get "/items/:id/edit", to: "items#edit"
  patch "/items/:id", to: "items#update"
  get "/merchants/:merchant_id/items", to: "items#index"
  get "/merchants/:merchant_id/items/new", to: "items#new"
  post "/merchants/:merchant_id/items", to: "items#create"
  delete "/items/:id", to: "items#destroy"

  get "/items/:item_id/reviews/new", to: "reviews#new"
  post "/items/:item_id/reviews", to: "reviews#create"

  get "/reviews/:id/edit", to: "reviews#edit"
  patch "/reviews/:id", to: "reviews#update"
  delete "/reviews/:id", to: "reviews#destroy"

  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"
  patch '/cart/:item_id/:increment_decrement', to: "cart#increment_decrement"

  get "/orders/new", to: "orders#new"
  post "/orders", to: "orders#create"
  # get "/orders/:id", to: "orders#show"

  get '/profile/orders', to: 'orders#index'
  post "/profile/orders", to: "orders#create"
  get "/profile/orders/:id", to: "orders#show"
  delete "/profile/orders/:id", to: "orders#destroy"

  get '/register', to: "users#new"
  post '/users', to: "users#create"
  get '/profile', to: "users#show"
  get '/profile/edit', to: "users#edit"
  get '/password', to: "users#edit_password"
  patch '/profile', to: "users#update"

  patch '/password', to: "users#update"

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"

  get '/logout', to: "sessions#destroy"

  namespace :merchant do
    get '/', to: 'dashboard#show'
    get '/items', to: 'items#index'
    get '/orders/:id', to: "orders#show"
    delete '/items/:item_id', to: "items#destroy"
    get '/items/new', to: "items#new"
    post '/items', to: "items#create"
    get '/items/:item_id/edit', to: "items#edit"
    patch '/items/:item_id', to: "items#update"
    patch '/items/:item_id/:status', to: "items#update"
    patch '/item_orders/:id', to: "item_orders#update"
    resources :discounts
    # delete "/orders/:id", to: "discounts#destroy"
  end

  namespace :admin do
    get '/', to: 'dashboard#index'
    get "/profile/:user_id", to: 'users#show'
    patch "/profile/:order_id", to: 'orders#update'

    get '/users', to: 'users#index'
    get '/users/:user_id', to: 'users#show'

    get '/merchants/:id', to: "merchants#show"
    get '/merchant/:id/items', to: "items#index"
    get '/merchant/orders/:id', to: "orders#show"
    get '/merchants', to: 'merchants#index'
    patch '/merchants/:id', to: 'merchants#update'
  end
end
