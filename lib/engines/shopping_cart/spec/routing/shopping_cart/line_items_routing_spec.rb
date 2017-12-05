require 'rails_helper'

module ShoppingCart
  RSpec.describe LineItemsController, type: :routing do
    routes { ShoppingCart::Engine.routes }

    describe 'routing' do
      it 'routes to #create' do
        expect(post: '/line_items')
          .to route_to('shopping_cart/line_items#create')
      end

      it 'routes to #update via PUT' do
        expect(put: '/line_items/1')
          .to route_to('shopping_cart/line_items#update', id: '1')
      end

      it 'routes to #update via PATCH' do
        expect(patch: '/line_items/1')
          .to route_to('shopping_cart/line_items#update', id: '1')
      end

      it 'routes to #destroy' do
        expect(delete: '/line_items/1')
          .to route_to('shopping_cart/line_items#destroy', id: '1')
      end
    end
  end
end
