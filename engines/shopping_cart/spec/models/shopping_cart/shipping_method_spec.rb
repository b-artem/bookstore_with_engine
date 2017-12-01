module ShoppingCart
  RSpec.describe ShippingMethod, type: :model do
    let(:shipping_method) { build :shopping_cart_shipping_method }

    it 'has a valid factory' do
      expect(shipping_method).to be_valid
    end

    describe 'associations' do
      it { is_expected.to have_many(:orders) }
    end
  end
end
