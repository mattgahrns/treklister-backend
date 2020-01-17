Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/login', to: 'auth#create'
  get '/profile', to: 'users#profile'
  post '/signup', to: 'users#create'
  get '/current_user', to: 'auth#show'
  post '/users/:id/new/trip', to: 'trips#create'
  get '/users/:id/trips', to: 'users#trips'
  get '/trip/:id', to: 'trips#show'
  get '/trip/:id/lists', to: 'trips#lists'
  post '/list/:id/new/item', to: 'list_items#create'
  delete '/item/:id/delete', to: 'list_items#destroy'
  get 'item/:id/', to: 'list_items#show'
  put 'item/:id/edit', to: 'list_items#update'
  put 'item/:id/check', to: 'list_items#check'
  put 'list/:id/uncheck/all', to: 'lists#uncheck_all'
  delete '/users/:id/delete', to: 'users#destroy'
end
