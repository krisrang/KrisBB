Kreubb::Application.routes.draw do
  delete "logout"     => "sessions#destroy",        as: "logout"
  get "login"         => "sessions#new",            as: "login"
  post "login_token"  => "sessions#create_token",   as: "login_token"
  get "signup"        => "users#new",               as: "signup"

  resources :messages, except: [:new, :edit] do
    get 'page/:page', :action => :index, :on => :collection
  end

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  root to: 'messages#bb'
end
