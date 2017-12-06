require 'rails_helper'
require 'support/capybara'
require 'support/devise'

module ShoppingCart
  shared_examples 'item view' do
    let(:product) { create :product }

    context 'when user wants to see Product details' do
      background do
        visit main_app.root_path
        create(:shopping_cart_line_item, cart: ShoppingCart::Cart.last,
                                         product: product)
        visit shopping_cart.cart_path(ShoppingCart::Cart.last)
      end

      context 'user clicks Photo' do
        scenario 'Product view page opens' do
          click_link "photo-view-#{product.id}"
          expect(current_path).to eq product_path(product)
        end
      end

      context 'user clicks Title' do
        scenario 'Product view page opens' do
          click_link "title-view-#{product.id}-xs"
          expect(current_path).to eq product_path(product)
        end
      end
    end
  end

  feature 'Cart' do
    feature 'Item view' do
      context 'when user is a guest' do
        it_behaves_like 'item view'
      end

      context 'when user is logged in' do
        let(:user) { create(:user) }
        background { sign_in user }
        it_behaves_like 'item view'
      end
    end
  end
end
