Rails.application.routes.draw do
  root 'messages#index'
  resources :messages

  get 'login', to: "users#new"
  post '/login', to: "users#create"
  delete '/logout', to: "users#destroy"

  mount ActionCable.server => '/cable'
end
