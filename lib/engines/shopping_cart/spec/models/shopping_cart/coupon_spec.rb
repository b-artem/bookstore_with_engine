require 'rails_helper'

module ShoppingCart
  RSpec.describe Coupon, type: :model do
    let(:coupon) { build :shopping_cart_coupon }

    it 'has a valid factory' do
      expect(coupon).to be_valid
    end

    context 'associations' do
      it { is_expected.to have_many(:carts) }
      it { is_expected.to have_many(:orders) }
    end

    context 'ActiveModel validations' do
      it { is_expected.to validate_presence_of(:code) }
      it { is_expected.to validate_presence_of(:discount) }
      it { is_expected.to validate_presence_of(:valid_until) }
      it { is_expected.to allow_value('AbZz0123').for(:code)
                          .with_message(I18n.t('models.coupon.coupon_symbols')) }
      it { is_expected.not_to allow_value('-+567abc').for(:code)
                          .with_message(I18n.t('models.coupon.coupon_symbols')) }
      it { is_expected.to validate_length_of(:code)
                          .is_at_least(8).is_at_most(12) }
      it { is_expected.to validate_numericality_of(:discount)
                          .is_greater_than_or_equal_to(0.1)
                          .is_less_than_or_equal_to(100) }
    end
  end
end
