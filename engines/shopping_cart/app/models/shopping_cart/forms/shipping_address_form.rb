module ShoppingCart
  module Forms
    class ShippingAddressForm < AddressForm
      def initialize(*args)
        super(*args)
        @type = 'ShoppingCart::ShippingAddress'
      end
    end
  end
end
