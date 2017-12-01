require 'rails_helper'
require 'support/factory_girl'

RSpec.describe LineItem, type: :model do
  let(:line_item) { build :line_item }

  it 'has a valid factory' do
    expect(line_item).to be_valid
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:cart) }
    it { is_expected.to belong_to(:order) }
  end

  describe 'ActiveModel validations' do
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_numericality_of(:quantity)
                        .only_integer.is_greater_than_or_equal_to(1) }
  end

  describe '#subtotal' do
    it 'calculates (:price * :quantity)' do
      line_item.price = 27
      line_item.quantity = 3
      expect(line_item.subtotal).to eq 81
    end
  end
end
