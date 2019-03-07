Rails.application.routes.draw do
  resources :comments
  resources :categories
  resources :posts
  resources :users

get '/signup', to: 'users#new'

get    '/login',   to: 'sessions#new'
post   '/login',   to: 'sessions#create'
delete '/logout',  to: 'sessions#destroy'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
