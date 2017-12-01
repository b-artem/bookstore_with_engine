require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Order, type: :model do
  let(:order) { build :order }

  it 'has a valid factory' do
    expect(order).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:shipping_method) }
    it { is_expected.to have_one(:billing_address).dependent(:destroy) }
    it { is_expected.to have_one(:shipping_address).dependent(:destroy) }
    it { is_expected.to have_many(:line_items).dependent(:destroy) }
  end

  describe 'aasm states' do
    it "initially has 'in_progress' state" do
      expect(order.state).to eq 'in_progress'
    end

    describe '#pay' do
      it "changes state from 'in_progress' to 'in_queue'" do
        expect { order.pay }.to change { order.state }
          .from('in_progress').to('in_queue')
      end
    end
  end

  describe 'public methods' do
    describe '#shipping_address' do
      context 'when not using :billing_address' do
        it 'returns :shipping_address' do
          order.use_billing_address_as_shipping = false
          shipping_address = build_stubbed(:shipping_address)
          order.shipping_address = shipping_address
          expect(order.shipping_address).to eq(shipping_address)
        end
      end

      context 'when using :billing_address' do
        it 'returns :billing_address' do
          order.use_billing_address_as_shipping = true
          billing_address = build_stubbed(:billing_address)
          order.billing_address = billing_address
          expect(order.shipping_address).to eq(billing_address)
        end
      end
    end

    describe '#subtotal' do
      it 'sums line_items subtotals' do
        line_item1 = create :line_item, price: 10, quantity: 1
        line_item2 = create :line_item, price: 20, quantity: 3
        order.line_items = [line_item1, line_item2]
        order.save
        expect(order.subtotal).to eq 70
      end
    end

    describe '#total' do
      context 'when :shipping_method is not set' do
        it 'returns items price' do
          order.shipping_method = nil
          allow(order).to receive(:subtotal).and_return(100)
          expect(order.total).to eq 100
        end
      end

      context 'when :shipping_method is set' do
        it 'returns items price + shipping price' do
          allow(order).to receive(:subtotal).and_return(100)
          allow(order).to receive_message_chain(:shipping_method, :price)
            .and_return(20)
          expect(order.total).to eq 120
        end
      end
    end

    describe '#discont' do
      context 'when :coupon is not set' do
        it 'returns 0' do
          expect(order.discount).to eq 0
        end
      end

      context 'when :coupon is set' do
        it 'returns discount amount' do
          allow(order).to receive(:subtotal).and_return(100)
          allow(order).to receive_message_chain(:coupon, :discount)
            .and_return(20)
          expect(order.discount).to eq 20
        end
      end
    end
  end

  describe 'private methods' do
    describe '#generate_number' do
      it 'assigns :number' do
        expect(order.number).to be_nil
        order.send(:generate_number)
        expect(order.number).not_to be_nil
      end


      after { order.send(:generate_number) }
      context 'when id is 123' do
        it 'generates :number R00000123' do
          allow(order).to receive(:id).and_return(123)
          order.send(:generate_number)
          expect(order.number).to eq 'R00000123'
        end
      end

      context 'when id is 12345678' do
        it 'generates :number R12345678' do
          allow(order).to receive(:id).and_return(12345678)
          order.send(:generate_number)
          expect(order.number).to eq 'R12345678'
        end
      end
    end
  end
end
