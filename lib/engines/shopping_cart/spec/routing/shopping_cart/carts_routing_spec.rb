require 'rails_helper'

module ShoppingCart
  RSpec.describe CartsController, type: :routing do
    routes { ShoppingCart::Engine.routes }

    describe 'routing' do
      it 'routes to #show' do
        expect(get: '/carts/1').to route_to('shopping_cart/carts#show', id: '1')
      end
    end
  end
end
