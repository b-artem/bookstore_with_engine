module ShoppingCart
  module Forms
    class BillingAddressForm < AddressForm
      def initialize(*args)
        super(*args)
        @type = 'ShoppingCart::BillingAddress'
      end
    end
  end
end
