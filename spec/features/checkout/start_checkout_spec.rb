require 'rails_helper'
require 'support/factory_girl'
require 'support/devise'
require 'support/i18n'
require 'rack_session_access/capybara'

feature 'Start checkout' do
  let!(:cart) { create :cart, line_items: [create(:line_item, cart: Cart.last)] }
  background do
    page.set_rack_session(cart_id: cart.id)
    allow_any_instance_of(Book).to receive_message_chain('images.[].image_url.file.url')
      .and_return("https://example.com/image.jpg")
  end

  context 'when user clicks Checkout button' do
    context 'when user is logged in' do
      background do
        sign_in create(:user)
        visit cart_path(cart)
        click_button 'checkout-btn'
      end
      scenario 'Checkout page opens, Addresses tab' do
        expect(page).to have_content t('orders.checkout.steps.checkout')
        expect(page).to have_content t('orders.checkout.address.billing_address')
        expect(page).to have_content t('orders.checkout.address.shipping_address')
      end
    end

    context 'when user is a guest' do
      background do
        visit cart_path(cart)
        click_button 'checkout-btn'
      end
      scenario 'Login page opens' do
        expect(page).to have_content t('devise.enter_email')
        expect(page).to have_content t('devise.password')
        expect(page).to have_button t('devise.sessions.new.sign_in')
        expect(page).not_to have_content t('orders.checkout.steps.checkout')
        expect(page).not_to have_content t('orders.checkout.address.billing_address')
        expect(page).not_to have_content t('orders.checkout.address.shipping_address')
      end
    end
  end
end
