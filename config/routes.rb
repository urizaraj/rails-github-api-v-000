Rails.application.routes.draw do
  get '/auth' => 'sessions#create'
  get '/users/auth/github/callback' => 'sessions#create'
  post '/repositories/create' => 'repositories#create'

  get '/update_username', to: 'sessions#update_username'

  root 'repositories#index'
end
