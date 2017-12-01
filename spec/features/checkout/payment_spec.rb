require 'support/factory_girl'
require 'support/devise'
require 'support/i18n'
require 'rack_session_access/capybara'
require 'support/wait_for_ajax'

feature 'Checkout Payment step' do
  let!(:user) { create :user }
  let(:billing_address) { build :billing_address }
  let(:shipping_address) { build :shipping_address }
  let(:shipping_method) { create :shipping_method }
  let!(:order) do
    create(:order, user: user, billing_address: billing_address,
           shipping_address: shipping_address, shipping_method: shipping_method)
  end
  let(:payment_info) { build :payment_form }
  let(:fields) { %w[card_number name_on_card valid_until cvv] }
  background do
    sign_in user
    page.set_rack_session(order_id: order.id)
    visit(order_checkout_index_path(order) + '/payment')
  end

  context 'when all data filled in correctly' do
    background do
      fill_payment_form
      click_button t('orders.checkout.save_and_continue')
    end

    scenario 'proceeds to Checkout Confirm step', js: true do
      expect(page).to have_content(t('orders.checkout.address.shipping_address'))
      expect(page).to have_content(t('orders.checkout.address.billing_address'))
      expect(page).to have_content(t('orders.checkout.confirm.shipments'))
      expect(page).to have_content(t('orders.checkout.confirm.edit'))
      expect(page).to have_button(t('orders.checkout.confirm.place_order'))
      expect(page).not_to have_content(t('orders.checkout.payment.card_number'))
    end
  end

  context 'when not all data filled in' do
    background do
      fill_payment_form
      fill_in(t("orders.checkout.payment.#{fields.sample}"), with: '')
      click_button t('orders.checkout.save_and_continue')
    end

    scenario 'renders payment form' do
      expect(page).to have_content(t('orders.checkout.payment.name_on_card'))
      expect(page).to have_content(t('orders.checkout.payment.card_number'))
      expect(page).to have_content(t('orders.checkout.payment.valid_until'))
      expect(page).to have_content(t('orders.checkout.payment.cvv'))
      expect(page).not_to have_button(t('orders.checkout.confirm.place_order'))
    end

  end

  private

    def fill_payment_form
      within 'form.new_payment' do
        fields.each do |field|
          fill_in(t("orders.checkout.payment.#{field}"),
                  with: payment_info.public_send(field))
        end
      end
    end
end
