Rails.application.routes.draw do
  root 'messages#index'
  resources :messages
  get '/activity', to: "messages#activity"

  get '/login', to: "users#new"
  post '/login', to: "users#create"
  delete '/logout', to: "users#destroy"
 
  mount ActionCable.server => '/cable'
end
