Rails.application.routes.draw do
  resources :users
  resources :categories
  resources :posts do
    resources :comments
  end


get '/signup', to: 'users#new'

get    '/login',   to: 'sessions#new'
post   '/login',   to: 'sessions#create'
delete '/logout',  to: 'sessions#destroy'
root 'categories#index'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
