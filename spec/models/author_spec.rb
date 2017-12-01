require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Author, type: :model do
  let(:author) { build :author }

  it 'has valid factory' do
    expect(author).to be_valid
  end

  describe 'Associations' do
    it { is_expected.to have_and_belong_to_many(:books) }
  end

  describe 'ActiveModel validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to allow_value('Elon').for(:first_name) }
    it { is_expected.not_to allow_value('Anna-Maria').for(:first_name)
                            .with_message('Only allows letters') }
    it { is_expected.to allow_value('Musk').for(:last_name) }
    it { is_expected.not_to allow_value('Chelimsky2').for(:last_name)
                            .with_message('Only allows letters') }
    it { is_expected.to validate_length_of(:first_name).is_at_most(49) }
    it { is_expected.to validate_length_of(:last_name).is_at_most(49) }
  end
end
