Rails.application.routes.draw do
  resources :books, only: [:index, :show] do
    resources :reviews, only: :create
  end
  resources :carts, only: [:show, :update]
  resources :line_items, only: [:create, :update, :destroy]
  resources :orders, controller: 'orders/orders', except: [:new, :edit, :update] do
    resources :checkout, controller: 'orders/checkout', only: [:index, :show, :update]
  end

  root 'home#index'
  get 'home/index'
  get 'settings/edit'
  put 'settings/update'
  patch 'settings/update_email'
  patch 'settings/change_password'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
end
