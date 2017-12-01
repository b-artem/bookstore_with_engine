require 'rails_helper'
require 'support/devise'
require 'support/factory_girl'

RSpec.describe CartsController, type: :controller do
  let(:cart) { create :cart }
  let(:coupon) { create :coupon }
  let(:valid_attributes) { attributes_for(:cart).merge(coupon: { code: coupon.code }) }
  let(:invalid_attributes) { attributes_for(:cart).merge(coupon: { code: 'abbccdd' }) }
  let(:valid_session) { { cart_id: cart.id } }

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: cart.id }, session: valid_session
      expect(response).to have_http_status 200
    end
  end

  describe 'PUT #update' do
    context 'with valid coupon params' do
      before do
        put :update, params: { id: cart.id, cart: valid_attributes },
                     session: valid_session
      end

      it 'updates the requested cart (saves valid coupon)' do
        expect(cart.reload.coupon).to eq coupon
      end

      it 'redirects to the cart' do
        expect(response).to redirect_to(cart)
      end
    end

    context 'with invalid coupon params' do
      before do
        put :update, params: { id: cart.id, cart: invalid_attributes },
                     session: valid_session
      end

      it 'does not update cart' do
        expect(cart.reload.coupon).to be_nil
      end

      it 'redirects to the cart' do
        expect(response).to redirect_to(cart)
      end
    end
  end
end
