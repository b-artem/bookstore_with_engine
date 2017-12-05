Rails.application.routes.draw do
  get 'welcome/index'
  root to: 'welcome#index'
  devise_for :users
  mount ShoppingCart::Engine => '/shopping_cart'
  resources :books, only: %i[index show]

end
