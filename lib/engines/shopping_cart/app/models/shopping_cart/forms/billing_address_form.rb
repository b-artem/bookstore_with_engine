module ShoppingCart
  module Forms
    class BillingAddressForm < Forms::AddressForm
      def initialize(*args)
        super(*args)
        @type = 'BillingAddress'
      end
    end
  end
end
