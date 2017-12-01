class Address < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :order, optional: true

  validates :type, inclusion: { in: %w(BillingAddress ShippingAddress),
    message: I18n.t('models.address.invalid_type', value: "%{value}" ) }
end
