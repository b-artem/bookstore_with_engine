require 'support/factory_girl'
require 'support/devise'
require 'support/i18n'
require 'rack_session_access/capybara'

shared_examples 'billing_address form is empty' do
  let(:address_fields) { %w[first_name last_name address city zip country phone] }
  scenario 'fields in Billing Address form are empty' do
    within 'div#billing-address-form' do
      address_fields.each do |field|
        expect(find_field(t("simple_form.labels.defaults.#{field}"))
                          .value).to be_blank
      end
    end
  end
end

shared_examples 'shipping_address form is empty' do
  let(:address_fields) { %w[first_name last_name address city zip country phone] }
  scenario 'fields in Shipping Address form are empty' do
    within 'div#shipping-address-form' do
      address_fields.each do |field|
      expect(find_field(t("simple_form.labels.defaults.#{field}"))
                        .value).to be_blank
      end
    end
  end
end

shared_examples 'billing_address form has proper values' do
  let(:address_fields) { %w[first_name last_name address city zip country phone] }
  scenario 'Billing Address form is filled with proper values' do
    within 'div#billing-address-form' do
      address_fields.each do |field|
        expect(find_field(t("simple_form.labels.defaults.#{field}"))
                          .value).to eq billing_address.public_send(field)
      end
    end
  end
end

shared_examples 'shipping_address form has proper values' do
  let(:address_fields) { %w[first_name last_name address city zip country phone] }
  scenario 'Shipping Address form is filled with proper values' do
    within 'div#shipping-address-form' do
      address_fields.each do |field|
        expect(find_field(t("simple_form.labels.defaults.#{field}"))
                          .value).to eq shipping_address.public_send(field)
      end
    end
  end
end

feature 'Checkout Address loads addresses from user Settings' do
  let!(:user) { create :user }
  let!(:order) { create :order, user: user }
  background do
    sign_in user
    page.set_rack_session(order_id: order.id)
    visit order_checkout_index_path(order)
  end

  scenario 'has form for Billing and Shipping addresses' do
    expect(page).to have_content t('orders.checkout.steps.checkout')
    expect(page).to have_content t('orders.checkout.address.billing_address')
    expect(page).to have_content t('orders.checkout.address.shipping_address')
  end

  scenario 'has order summary' do
    expect(page).to have_content t('orders.checkout.order_summary.order_summary')
    expect(page).to have_content t('orders.checkout.order_summary.subtotal')
    expect(page).to have_content t('orders.checkout.order_summary.coupon')
    expect(page).to have_content t('orders.checkout.order_summary.shipping')
    expect(page).to have_content t('orders.checkout.order_summary.order_total')
  end

  context 'when user has not filled Billing Address in Settings page' do
    include_examples 'billing_address form is empty'
  end

  context 'when user has not filled Shipping Address in Settings page' do
    include_examples 'shipping_address form is empty'
  end

  context 'when user has filled only Billing Address in Settings page' do
    let(:billing_address) { create :billing_address }
    background do
      user.billing_address = billing_address
      visit order_checkout_index_path(order)
    end

    include_examples 'billing_address form has proper values'
    include_examples 'shipping_address form is empty'
  end

  context 'when user has filled only Shipping Address in Settings page' do
    let(:shipping_address) { create :shipping_address }
    background do
      user.shipping_address = shipping_address
      visit order_checkout_index_path(order)
    end

    include_examples 'billing_address form is empty'
    include_examples 'shipping_address form has proper values'
  end

  context 'when user has filled both Billing and Shipping Addresses in Settings page' do
    let(:billing_address) { create :billing_address }
    let(:shipping_address) { create :shipping_address }
    background do
      user.billing_address = billing_address
      user.shipping_address = shipping_address
      visit order_checkout_index_path(order)
    end

    include_examples 'billing_address form has proper values'
    include_examples 'shipping_address form has proper values'
  end
end
