require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Forms::PaymentForm, type: :model do
  let(:payment_form) { build :payment_form }

  it 'has a valid factory' do
    expect(payment_form).to be_valid
  end

  context 'FormObject validations' do
    it { is_expected.to validate_presence_of(:card_number) }
    it { is_expected.to validate_presence_of(:name_on_card) }
    it { is_expected.to validate_presence_of(:valid_until) }
    it { is_expected.to validate_presence_of(:cvv) }

    it { is_expected.to allow_value('1234567812345678').for(:card_number) }
    it { is_expected.not_to allow_value('1234-5678-1234-5678').for(:card_number)
                            .with_message('Only allows 0-9') }
    it { is_expected.not_to allow_value('1234 5678 1234 5678').for(:card_number)
                            .with_message('Only allows 0-9') }

    it { is_expected.to allow_value('Elon Musk').for(:name_on_card) }
    it { is_expected.not_to allow_value('Elon-Musk').for(:name_on_card)
                            .with_message('Only allows letters and spaces') }
    it { is_expected.to validate_length_of(:name_on_card).is_at_most(49) }

    it { is_expected.to allow_value(Date.today.strftime('%m/%y').to_s).for(:valid_until) }
    it { is_expected.to allow_value("12/25").for(:valid_until) }
    it { is_expected.not_to allow_value((Date.today - 1.months).strftime('%m/%y').to_s)
                            .for(:valid_until).with_message('Invalid term') }
    it { is_expected.not_to allow_value("12/2025").for(:valid_until)
                            .with_message('Invalid term') }
    it { is_expected.not_to allow_value("12-25").for(:valid_until)
                            .with_message('Invalid term') }
    it { is_expected.not_to allow_value("1225").for(:valid_until)
                            .with_message('Invalid term') }

    it { is_expected.to allow_value('123').for(:cvv) }
    it { is_expected.to allow_value("1234").for(:cvv) }
    it { is_expected.not_to allow_value('a123')
                            .for(:cvv).with_message('Only allows 0-9') }
    it { is_expected.not_to allow_value("12-34").for(:cvv)
                            .with_message('Only allows 0-9') }
    it { is_expected.to validate_length_of(:cvv).is_at_least(3) }
  end
end
