Rails.application.routes.draw do
  use_doorkeeper
  use_doorkeeper_openid_connect
  devise_for :users, controllers: {omniauth_callbacks: 'authentications'}
  namespace :my do
    resource :account, only: [:update] do
      resource :setup, controller: 'account_setups', only: [:show]
      resource :byebye, controller: 'account_byebyes', only: [:show]
    end
  end
  authenticated :user do
    root 'pages#index', as: :authenticated_user_root
  end
  root to: 'pages#index', via: [:get, :post]
end
