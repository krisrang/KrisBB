Kreubb::Application.routes.draw do
  delete "logout"     => "sessions#destroy",        as: "logout"
  get "login"         => "sessions#new",            as: "login"
  get "signup"        => "users#new",               as: "signup"

  resources :messages, except: [:new, :edit] do
    get 'page/:page', :action => :index, :on => :collection
  end

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  root to: 'messages#bb'
end
