require 'rails_helper'
require 'support/factory_girl'

RSpec.describe User, type: :model do
  let(:user) { build :user }

  it 'has a valid factory' do
    expect(user).to be_valid
  end

  context 'associations' do
    it { is_expected.to have_many(:orders) }
    it { is_expected.to have_many(:reviews) }
    it { is_expected.to have_one(:billing_address) }
    it { is_expected.to have_one(:shipping_address) }
  end


  context 'ActiveModel validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it 'validates uniqueness of :email' do
      expect(user).to validate_uniqueness_of(:email).case_insensitive
    end
    it { is_expected.not_to allow_value('http://foo.com').for(:email) }
    it { is_expected.to validate_length_of(:password).is_at_least(8) }
    it { is_expected.to validate_confirmation_of(:password) }
    it 'validates many validations TBD'
  end
end
