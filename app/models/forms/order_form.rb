class Forms::OrderForm < Rectify::Form
  attribute :billing_address, Forms::BillingAddressForm
  attribute :shipping_address, Forms::ShippingAddressForm
  attribute :use_billing_address_as_shipping, Boolean

  validates :billing_address, presence: true
  validates :shipping_address, presence: true, if: :need_shipping_address?

  def save
    return false unless valid?
    Order.find(id).update_attributes(use_billing_address_as_shipping:
                                      use_billing_address_as_shipping)
    Order.find(id).billing_address = Address.create(billing_address.attributes)
    unless use_billing_address_as_shipping
      Order.find(id).shipping_address = Address.create(shipping_address.attributes)
    end
    true
  end

  def need_shipping_address?
    true unless use_billing_address_as_shipping
  end
end
