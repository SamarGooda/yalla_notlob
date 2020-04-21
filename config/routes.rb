Rails.application.routes.draw do
  
  post 'register', to: 'authintication#register'
  post 'login', to: 'authintication#login'
  root :to => "authintication#index"
  get '/home' => 'home#index'
  get '/orders/add' => 'add_orders#index'
  get '/orders' => 'add_orders#list'
  # get '/orders' => 'list_orders#index'
  post '/add' => 'add_orders#add'
  post '/cancel/:id' => 'add_orders#cancel'
  post '/finish/:id' => 'add_orders#finish'
  get '/friends/search' => 'friends#search', :as => 'search_page'

  resources :friends
  resources :groups
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
