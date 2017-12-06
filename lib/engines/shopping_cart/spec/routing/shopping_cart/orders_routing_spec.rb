require 'rails_helper'

module ShoppingCart
  RSpec.describe Orders::OrdersController, type: :routing do
    routes { ShoppingCart::Engine.routes }

    describe 'routing' do
      it 'routes to #index' do
        expect(get: '/orders')
          .to route_to('shopping_cart/orders/orders#index')
      end

      it 'routes to #show' do
        expect(get: '/orders/1')
          .to route_to('shopping_cart/orders/orders#show', id: '1')
      end

      it 'routes to #create' do
        expect(post: '/orders')
          .to route_to('shopping_cart/orders/orders#create')
      end
    end
  end
end
