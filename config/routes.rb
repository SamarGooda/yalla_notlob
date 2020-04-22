Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #  get "/post/", to: "posts#index"
  # root  '/'

  get '/friends/search' => 'friends#search', :as => 'search_page'
  get '/groups/get_group_id/:id' => 'groups#get_group_id', :as => 'get_group_id'
  # get '/groups/delete_friend/:id/:email' => 'groups#delete_friend', :as => 'delete_friend'
  delete '/delete_friend/:id' => 'groups#delete_friend', :as => 'delete_friend'





  resources :friends
  resources :groups
  

 
end
