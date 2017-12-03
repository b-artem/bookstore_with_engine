require 'support/factory_bot'
require 'support/devise'
require 'support/i18n'
require 'rack_session_access/capybara'
require 'support/wait_for_ajax'

shared_examples 'saves billing address' do
  background do
    click_button t('shopping_cart.orders.checkout.save_and_continue')
    wait_for_ajax
  end

  scenario 'saves billing address from a form fields', js: true do
    address_fields.each do |field|
      expect(ShoppingCart::Order.find(order.id).billing_address.public_send(field))
        .to eq billing_address.public_send(field)
    end
  end
end

shared_examples 'saves shipping address' do
  background do
    click_button t('shopping_cart.orders.checkout.save_and_continue')
    wait_for_ajax
  end

  scenario 'saves shipping address from a form fields', js: true do
    address_fields.each do |field|
      expect(ShoppingCart::Order.find(order.id).shipping_address.public_send(field))
        .to eq shipping_address.public_send(field)
    end
  end
end

shared_examples 'uses billing address as shipping' do
  background do
    click_button t('shopping_cart.orders.checkout.save_and_continue')
    wait_for_ajax
  end

  scenario 'uses Billing Address as Shipping Address', js: true do
    address_fields.each do |field|
      expect(ShoppingCart::Order.find(order.id).shipping_address.public_send(field))
        .to eq billing_address.public_send(field)
    end
  end
end

shared_examples 'does not save addresses' do
  background do
    click_button t('shopping_cart.orders.checkout.save_and_continue')
    wait_for_ajax
  end

  scenario 'does NOT save Addresses and renders form again', js: true do
    expect(ShoppingCart::Order.find(order.id).billing_address).to be_nil
    expect(ShoppingCart::Order.find(order.id).shipping_address).to be_nil
  end
end

shared_examples 'proceeds to next step' do
  context 'when user clicks Save and Continue button' do
    background do
      click_button t('shopping_cart.orders.checkout.save_and_continue')
      wait_for_ajax
    end

    scenario 'renders next step (Delivery)', js: true do
      expect(page).to have_content(t('shopping_cart.orders.checkout.delivery.shipping_method'))
      expect(page).to have_content(t('shopping_cart.orders.checkout.delivery.days'))
      expect(page).to have_content(t('shopping_cart.orders.checkout.delivery.price'))
    end
  end
end

shared_examples 'renders address form again' do
  background do
    click_button t('shopping_cart.orders.checkout.save_and_continue')
    wait_for_ajax
  end

  scenario 'renders next step (Delivery)', js: true do
    expect(page).to have_content(t('shopping_cart.orders.checkout.address.billing_address'))
    expect(page).to have_content(t('shopping_cart.orders.checkout.address.shipping_address'))
    expect(page).to have_content(t('shopping_cart.orders.checkout.address.all_fields_are_required'))
  end
end

feature 'Checkout Address step' do
  let!(:user) { create :user }
  let!(:order) { create :shopping_cart_order, user: user }
  let(:address_fields) { %w[first_name last_name address city zip country phone] }
  let(:billing_address) { build :shopping_cart_billing_address }
  let(:shipping_address) { build :shopping_cart_shipping_address }
  background do
    sign_in user
    page.set_rack_session(order_id: order.id)
    create :shopping_cart_shipping_method
    visit shopping_cart.order_checkout_index_path(order)
  end

  context 'when all required fields are filled correctly' do
    background { fill_billing_address(billing_address) }

    context 'when Use Billing Address checkbox is selected' do
      background { find('label.checkbox-label').click }
      it_behaves_like 'saves billing address'
      it_behaves_like 'uses billing address as shipping'
      it_behaves_like 'proceeds to next step'
    end

    context 'when Use Billing Address checkbox is NOT selected' do
      background { fill_shipping_address(shipping_address) }
      it_behaves_like 'saves billing address'
      it_behaves_like 'saves shipping address'
      it_behaves_like 'proceeds to next step'
    end
  end

  context 'when not all required fields are filled correctly' do
    background { fill_billing_address(billing_address) }

    context 'when Use Billing Address checkbox is selected' do
      background do
        within '#billing-address-form' do
          field = %w[first_name last_name address city zip phone].sample
          fill_in(t("simple_form.labels.defaults.#{field}"), with: '')
        end
        find('label.checkbox-label').click
      end
      it_behaves_like 'does not save addresses'
      it_behaves_like 'renders address form again'
    end

    context 'when Use Billing Address checkbox is not selected' do
      background do
        fill_shipping_address(shipping_address)
        within '#shipping-address-form' do
          field = %w[first_name last_name address city zip phone].sample
          fill_in(t("simple_form.labels.defaults.#{field}"), with: '')
        end
      end
      it_behaves_like 'does not save addresses'
      it_behaves_like 'renders address form again'
    end
  end

  private

    def fill_billing_address(address)
      within '#billing-address-form' do
        fill_address(address)
      end
    end

    def fill_shipping_address(address)
      within '#shipping-address-form' do
        fill_address(address)
      end
    end

    def fill_address(address)
      address_fields.each do |field|
        if field == 'country'
          select(address.decorate.public_send(field),
                 from: t("simple_form.labels.defaults.#{field}"))
          next
        end
        fill_in(t("simple_form.labels.defaults.#{field}"),
                with: address.public_send(field))
      end
    end
end
