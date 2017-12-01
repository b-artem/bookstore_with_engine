require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Forms::AddressForm, type: :model do
  let(:address_form) { build :address_form }

  it 'has a valid factory' do
    allow(address_form).to receive(:need_shipping_address?).and_return(true)
    expect(address_form).to be_valid
  end

  context 'FormObject validations' do
    it { is_expected.to validate_presence_of(:type) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:zip) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:phone) }

    it { is_expected.to allow_value('Elon').for(:first_name) }
    it { is_expected.not_to allow_value('Anna-Maria').for(:first_name)
                            .with_message('Only allows letters') }
    it { is_expected.to allow_value('Musk').for(:last_name) }
    it { is_expected.not_to allow_value('Chelimsky2').for(:last_name)
                            .with_message('Only allows letters') }
    it { is_expected.to validate_length_of(:first_name).is_at_most(49) }
    it { is_expected.to validate_length_of(:last_name).is_at_most(49) }

    it { is_expected.to allow_value('a-z, A-Z, 0-9').for(:address) }
    it { is_expected.not_to allow_value('/').for(:address)
          .with_message("Only allows a-z, A-Z, 0-9,’,’, ‘-’, ‘ ’") }
    it { is_expected.to validate_length_of(:address).is_at_most(49) }

    it { is_expected.to allow_value('South Africa').for(:country) }
    it { is_expected.not_to allow_value('South-Africa').for(:country)
          .with_message("Only allows a-z, ' ', A-Z") }
    it { is_expected.to validate_length_of(:country).is_at_most(49) }

    it { is_expected.to allow_value('Buenos Aires').for(:city) }
    it { is_expected.not_to allow_value('Buenos-Aires').for(:city)
          .with_message("Only allows a-z, ' ', A-Z") }
    it { is_expected.to validate_length_of(:city).is_at_most(49) }

    it { is_expected.to allow_value('123-456').for(:zip) }
    it { is_expected.to allow_value('1234').for(:zip) }
    it { is_expected.not_to allow_value('123 456').for(:zip)
          .with_message("Only allows 0-9 '-'") }
    it { is_expected.to validate_length_of(:zip).is_at_most(10) }

    it { is_expected.to allow_value('+380123456789').for(:phone) }
    it { is_expected.not_to allow_value('380123456789').for(:phone)
          .with_message("Only allows '+', 0-9") }
    it { is_expected.not_to allow_value('+380 12 345 67 89').for(:phone) }
    it { is_expected.not_to allow_value('+380(12)3456789').for(:phone) }
    it { is_expected.not_to allow_value('+380-12-345-67-89').for(:phone) }
    it { is_expected.to validate_length_of(:phone).is_at_most(15) }
  end
end
