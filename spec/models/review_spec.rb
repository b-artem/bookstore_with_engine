require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Review, type: :model do
  let(:review) { build :review }

  it 'has a valid factory' do
    expect(review).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'ActiveModel validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:text) }
    it {is_expected.to allow_value("Az7!#$%&'*+ -/=?^_`{|}~.").for(:title) }
    it {is_expected.to allow_value("Az7!#$%&'*+ -/=?^_`{|}~.").for(:title) }
    it { is_expected.not_to allow_value("@").for(:title)
        .with_message("Only allows letters, numbers or !#$%&'*+-/=?^_`{|}~. ") }
    it { is_expected.not_to allow_value("@").for(:text)
        .with_message("Only allows letters, numbers or !#$%&'*+-/=?^_`{|}~. ") }
    it { is_expected.to validate_length_of(:title).is_at_most(79) }
    it { is_expected.to validate_length_of(:text).is_at_most(499) }
  end

  describe 'scopes' do
    let!(:unprocessed) { create_list(:review, 3, status: 'unprocessed') }
    let!(:approved) { create_list(:review, 3, status: 'approved') }
    let!(:rejected) { create_list(:review, 3, status: 'rejected') }

    context 'when .new_' do
      it "selects reviews with status 'unprocessed'" do
        expect(Review.new_).to eq unprocessed
      end
    end

    context 'when .processed' do
      it "selects reviews with status 'approved' or 'rejected'" do
        expect(Review.processed).to eq(approved + rejected)
      end
    end
  end

  describe 'aasm states' do
    it "initially has 'unprocessed' status" do
      expect(review.status).to eq 'unprocessed'
    end

    describe '#approve' do
      it "changes state from 'unprocessed' to 'approved'" do
        expect { review.approve }.to change { review.status }
                .from('unprocessed').to('approved')
      end
    end

    describe '#reject' do
      it "changes state from 'unprocessed' to 'rejected'" do
        expect { review.reject }.to change { review.status }
                .from('unprocessed').to('rejected')
      end
    end
  end
end
