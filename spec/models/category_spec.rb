require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Category, type: :model do
  let(:category) { build :category }

  it 'has a valid factory' do
    expect(category).to be_valid
  end

  describe 'associations' do
    it { is_expected.to have_and_belong_to_many(:books) }
  end

  describe 'ActiveModel validations' do
    it { is_expected.to validate_presence_of(:name) }
    it 'validates uniqueness of :name' do
      expect(category).to validate_uniqueness_of(:name).case_insensitive
    end
  end
end
