Kreubb::Application.routes.draw do
  if Rails.env.development?
    mount Notifications::Preview => 'mail_view'
  end

  get     "ping"        => "sessions#ping",           as: "ping"
  get     "login"       => "sessions#new",            as: "login"
  get     "signup"      => "users#new",               as: "signup"
  post    "login_token" => "sessions#login_token",    as: "login_token"
  post    "pusher/auth" => "sessions#pusher",         as: "pusher_auth"
  delete  "logout"      => "sessions#destroy",        as: "logout"

  resources :messages, except: [:new, :edit] do
    collection do
      get 'page/:page', action: :index
      post :from_email
    end
  end

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  root to: 'messages#bb'
end
