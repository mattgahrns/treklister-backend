Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/login', to: 'auth#create'
  get '/profile', to: 'users#profile'
  post '/signup', to: 'users#create'
  get '/current_user', to: 'auth#show'
  post '/users/:id/new/trip', to: 'trips#create'
  get '/users/:id/trips', to: 'users#trips'
  get '/trip/:id', to: 'trips#show'
end
