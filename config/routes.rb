Kreubb::Application.routes.draw do
  delete "logout"     => "sessions#destroy",        as: "logout"
  get "login"         => "sessions#new",            as: "login"
  get "signup"        => "users#new",               as: "signup"
  get "mobile_login"  => "sessions#mobile_login",   as: "mobile_login"

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  resources :messages
  root to: 'messages#index'
end
