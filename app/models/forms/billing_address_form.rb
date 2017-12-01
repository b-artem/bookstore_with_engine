class Forms::BillingAddressForm < Forms::AddressForm
  def initialize(*args)
    super(*args)
    @type = 'BillingAddress'
  end
end
