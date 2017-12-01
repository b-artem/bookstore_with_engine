Rails.application.routes.draw do
  resources :books, only: [:index, :show] do
    resources :reviews, only: :create
  end

  root 'home#index'
  get 'home/index'
  get 'settings/edit'
  put 'settings/update'
  patch 'settings/update_email'
  patch 'settings/change_password'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount ShoppingCart::Engine => '/shopping_cart'
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
end
