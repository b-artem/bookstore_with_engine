module ShoppingCart
  module Forms
    class Forms::ShippingAddressForm < Forms::AddressForm
      def initialize(*args)
        super(*args)
        @type = 'ShippingAddress'
      end
    end
  end
end
