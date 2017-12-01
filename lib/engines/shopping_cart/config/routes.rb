ShoppingCart::Engine.routes.draw do
  resources :carts, only: %i[show update]
  resources :line_items, only: %i[create update destroy]
  resources :orders, controller: 'orders/orders', only: %i[index show create] do
    resources :checkout, controller: 'orders/checkout', only: %i[index show update]
  end
end
