Rails.application.routes.draw do
  resources :list_items
  resources :lists
  resources :trips
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
