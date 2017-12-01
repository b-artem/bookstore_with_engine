require 'support/factory_girl'
require 'support/devise'
require 'support/i18n'
require 'rack_session_access/capybara'
require 'support/wait_for_ajax'

feature 'Checkout Delivery step' do
  let!(:user) { create :user }
  let(:billing_address) { build :billing_address }
  let(:shipping_address) { build :shipping_address }
  let!(:order) do
    create :order, user: user, billing_address: billing_address,
                   shipping_address: shipping_address
  end
  let!(:shipping_methods) do
  [
    create(:shipping_method, name: 'Pick Up In-Store', days_min: 5,
                             days_max: 20, price: 10.0),
    create(:shipping_method, name: 'Delivery Next Day!', days_min: 3,
                             days_max: 7, price: 5.0),
    create(:shipping_method, name: 'Expressit', days_min: 2,
                             days_max: 3, price: 15.0)
  ]
  end
  background do
    sign_in user
    page.set_rack_session(order_id: order.id)
    visit(order_checkout_index_path(order) + '/delivery')
  end

  context 'when Order has shipping method' do
    let(:shipping_method) { shipping_methods.sample }
    background do
      order.update_attributes(shipping_method: shipping_method)
      visit(order_checkout_index_path(order) + '/delivery')
    end

    scenario 'current shipping method is checked', js: true do
      within 'table#shipping-methods' do
        input = find("input.radio-input[value='#{shipping_method.id}']",
                     visible: false)
        expect(input).to be_checked
      end
    end
  end

  context 'when Order has no shipping method yet' do
    scenario 'the cheapest shipping method is checked', js: true do
      within 'table#shipping-methods' do
        input = find("input.radio-input[value='2']", visible: false)
        expect(input).to be_checked
      end
    end
  end

  context 'when user cliks Save and Continue button' do
    let(:shipping_method) { shipping_methods.sample }
    background do
      within 'table#shipping-methods' do
        find('span.radio-text', text: shipping_method.name).click
      end
      click_button t('orders.checkout.save_and_continue')
      wait_for_ajax
    end

    scenario 'saves chosen shipping method', js: true do
      expect(Order.find(order.id).shipping_method).to eq shipping_method
    end

    scenario 'proceeds to Checkout Payment step', js: true do
      expect(page).to have_content(t('orders.checkout.payment.name_on_card'))
      expect(page).to have_content(t('orders.checkout.payment.cvv'))
      expect(page).not_to have_button(t('orders.checkout.confirm.place_order'))
    end
  end
end
