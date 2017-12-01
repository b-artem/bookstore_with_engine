require 'support/capybara'
require 'support/devise'
require 'support/i18n'
require 'rack_session_access/capybara'

module ShoppingCart
  shared_examples 'checkout address page opens' do
    scenario 'Checkout Address page opens' do
      expect(page).to have_content(t('shopping_cart.orders.checkout.address.shipping_address'))
      expect(page).to have_content(t('shopping_cart.orders.checkout.address.all_fields_are_required'))
      expect(page).to have_content(t('shopping_cart.orders.checkout.address.use_billing_address'))
      expect(page).not_to have_button(t('shopping_cart.orders.checkout.confirm.place_order'))
    end
  end

  shared_examples 'than returns to confirm page' do
    context 'when user than clicks Save and Continue button' do
      background { click_button(t('shopping_cart.orders.checkout.save_and_continue')) }
      scenario 'returns to Checkout Confirm page' do
        expect(page).to have_content(t('shopping_cart.orders.checkout.confirm.edit'))
        expect(page).to have_content(t('shopping_cart.orders.checkout.confirm.shipments'))
        expect(page).to have_content(t('shopping_cart.orders.checkout.confirm.payment_information'))
        expect(page).to have_button(t('shopping_cart.orders.checkout.confirm.place_order'))
        within '#total' do
          expect(page).to have_content(order.decorate.total)
        end
      end
    end
  end

  feature 'Checkout Payment step' do
    let!(:user) { create :user }
    let(:billing_address) { build :shopping_cart_billing_address }
    let(:shipping_address) { build :shopping_cart_shipping_address }
    let(:shipping_method) { create :shopping_cart_shipping_method }
    let(:products) { build_list(:product, 2) }
    let(:line_items) do
      [create(:shopping_cart_line_item, product: products[0]),
        create(:shopping_cart_line_item, product: products[1])]
    end
    let!(:order) do
      create(:shopping_cart_order, user: user, line_items: line_items,
             billing_address: billing_address, shipping_address: shipping_address,
             shipping_method: shipping_method)
    end
    let(:payment_info) { build :shopping_cart_forms_payment_form }
    let(:payment_fields) { %w[card_number name_on_card valid_until cvv] }
    background do
      sign_in user
      page.set_rack_session(order_id: order.id)
      payment_fields.each do |field|
        page.set_rack_session(field => payment_info.public_send(field))
      end
      visit(shopping_cart.order_checkout_index_path(order) + '/confirm')
    end

    context 'when user wants to edit some information' do
      context 'when user clicks Edit Shipping Address link' do
        background do
          within '#shipping-address' do
            click_link(t('shopping_cart.orders.checkout.confirm.edit'))
          end
        end
        include_examples 'checkout address page opens'
        include_examples 'than returns to confirm page'
      end

      context 'when user clicks Edit Billing Address link' do
        background do
          within '#billing-address' do
            click_link(t('shopping_cart.orders.checkout.confirm.edit'))
          end
        end
        include_examples 'checkout address page opens'
        include_examples 'than returns to confirm page'
      end

      context 'when user clicks Edit Shipment link' do
        background do
          within '#shipment' do
            click_link(t('shopping_cart.orders.checkout.confirm.edit'))
          end
        end

        scenario 'Checkout Delivery page opens' do
          expect(page).to have_content(t('shopping_cart.orders.checkout.delivery.method'))
          expect(page).to have_content(t('shopping_cart.orders.checkout.delivery.days'))
          expect(page).to have_content(t('shopping_cart.orders.checkout.delivery.price'))
          expect(page).not_to have_button(t('shopping_cart.orders.checkout.confirm.place_order'))
        end

        include_examples 'than returns to confirm page'
      end

      context 'when user clicks Edit Payment information link' do
        background do
          within '#payment' do
            click_link(t('shopping_cart.orders.checkout.confirm.edit'))
          end
        end

        scenario 'Checkout Payment page opens' do
          expect(page).to have_content(t('shopping_cart.orders.checkout.payment.name_on_card'))
          expect(page).to have_content(t('shopping_cart.orders.checkout.payment.card_number'))
          expect(page).to have_content(t('shopping_cart.orders.checkout.payment.cvv'))
          expect(page).not_to have_button(t('shopping_cart.orders.checkout.confirm.place_order'))
        end

        include_examples 'than returns to confirm page'
      end
    end

    context 'when user clicks Place Order button' do
      background { click_button t('shopping_cart.orders.checkout.confirm.place_order') }
      scenario 'Checkout Complete page opens' do
        expect(page).to have_content(t('shopping_cart.orders.checkout.complete.thank_you_for_your_order'))
        expect(page).to have_content(t('shopping_cart.orders.checkout.complete.order_confirmation_has_been_sent'))
        expect(page).to have_button(t('shopping_cart.orders.checkout.complete.back_to_store'))
      end
    end
  end
end
