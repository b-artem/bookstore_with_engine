require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Cart, type: :model do
  let(:cart) { build :cart }

  it 'has a valid factory' do
    expect(cart).to be_valid
  end

  describe 'Associations' do
    it { is_expected.to have_many(:line_items).dependent(:destroy) }
  end

  describe 'Instance methods' do
    let(:cart) { create :cart }
    let(:book) { create :book }

    describe '#add_product' do
      context 'when number is positive integer' do
        context 'when product is not in cart yet' do
          it 'adds product to cart' do
            expect { cart.add_product(book, 3) }.to change {
              cart.line_items.length }.by 1
          end
        end

        context 'when product is already in cart' do
          it 'increase quantity of product in cart' do
            cart.add_product(book, 1).save
            expect { cart.add_product(book, 2).save }.to change {
              cart.line_items.first.quantity }.from(1).to(3)
          end
        end
      end

      context 'when number is negative' do
        it 'does not add product' do
          expect { cart.add_product(book, -3) }.not_to change {
            cart.line_items.length }
        end
      end

      context 'when number is not integer' do
        it 'does not add product' do
          expect { cart.add_product(book, 3.27) }.not_to change {
            cart.line_items.length }
        end
      end
    end

    describe '#subtotal' do
      it 'sums line_items subtotals' do
        line_item1 = build :line_item, price: 10, quantity: 1
        line_item2 = build :line_item, price: 20, quantity: 3
        cart.line_items = [line_item1, line_item2]
        expect(cart.subtotal).to eq 70
      end
    end

    describe '#total' do
      let(:coupon) { build :coupon, discount: '30' }
      before { cart.coupon = coupon }
      it 'calculates (subtotal - discount)' do
        allow(cart).to receive(:subtotal).and_return(100)
        expect(cart.total).to eq 70
      end
    end
  end
end
