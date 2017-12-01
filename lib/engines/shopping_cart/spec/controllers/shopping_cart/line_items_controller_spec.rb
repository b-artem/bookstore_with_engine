require 'rails_helper'
require 'support/devise'

module ShoppingCart
  RSpec.describe LineItemsController, type: :controller do
    routes { Engine.routes }
    let(:main_app_root_path) { Rails.application.routes.url_helpers.root_path }

    let(:cart) { create :shopping_cart_cart }
    let(:product) { create :product }
    let(:valid_attributes) { { quantity: 1 } }
    let(:invalid_attributes) { { quantity: 2.3 } }
    let(:valid_session) { { cart_id: cart.id } }
    let(:line_item) { create :shopping_cart_line_item, cart: cart }

    describe 'POST #create' do
      context 'with valid params' do
        it 'creates a new LineItem' do
          expect do
            post :create, params: valid_attributes.merge(product_id: product.id),
                          session: valid_session
          end.to change(LineItem, :count).by(1)
        end

        it 'redirects back' do
          post :create, params: valid_attributes.merge(product_id: product.id),
                        session: valid_session
          expect(response).to redirect_to(main_app_root_path)
        end
      end

      context 'with invalid params' do
        it 'does not create a new LineItem' do
          expect do
            post :create, params: invalid_attributes.merge(product_id: product.id),
                          session: valid_session
          end.not_to change(LineItem, :count)
        end

        it 'redirects back' do
          post :create, params: invalid_attributes.merge(product_id: product.id),
                        session: valid_session
          expect(response).to redirect_to(main_app_root_path)
        end
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        before do
          put :update, format: 'js', session: valid_session,
              params: { id: line_item.id, line_item: { quantity: 5 } }
        end

        it 'updates the requested line_item' do
          expect(line_item.reload.quantity).to eq 5
        end
        it 'returns status code 200' do
          expect(response).to have_http_status 200
        end
      end

      context 'with invalid params' do
        before do
          put :update, format: 'js', session: valid_session,
              params: { id: line_item.id, line_item: { quantity: '2.43' } }
        end

        it 'does not update the requested line_item' do
          expect(line_item.reload.quantity).to eq 1
        end
        it 'redirects to the Cart' do
          expect(response).to redirect_to cart_url(cart)
        end
      end
    end

    describe 'DELETE #destroy' do
      let!(:line_item) { create :shopping_cart_line_item, cart: cart }

      it 'destroys the requested line_item' do
        expect do
          delete :destroy, params: { id: line_item.id }, session: valid_session
        end.to change(LineItem, :count).by(-1)
      end

      it 'redirects to the Cart' do
        delete :destroy, params: { id: line_item.id }, session: valid_session
        expect(response).to redirect_to cart_url(cart)
      end
    end
  end
end
