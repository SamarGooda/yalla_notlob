Rails.application.routes.draw do
  get '/home' => 'home#index'
  get '/add_orders' => 'add_orders#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
