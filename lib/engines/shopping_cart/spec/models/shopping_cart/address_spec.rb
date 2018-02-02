require 'rails_helper'

module ShoppingCart
  RSpec.describe Address, type: :model do
    let(:address) { build :shopping_cart_address }

    it 'has a valid factory' do
      expect(address).to be_valid
    end

    context 'associations' do
      it { is_expected.to belong_to(:user) }
      it { is_expected.to belong_to(:order) }
    end

    context 'ActiveModel validations' do
      it { is_expected.to validate_inclusion_of(:type)
          .in_array(%w(ShoppingCart::BillingAddress ShoppingCart::ShippingAddress)) }
    end
  end
end
