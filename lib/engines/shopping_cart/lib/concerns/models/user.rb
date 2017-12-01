module ShoppingCart
  module Concerns
    module Models
      module User
        extend ActiveSupport::Concern

        included do
          has_many :orders, class_name: 'ShoppingCart::Order'
          has_one :billing_address, class_name: 'ShoppingCart::BillingAddress'
          has_one :shipping_address, class_name: 'ShoppingCart::ShippingAddress'
        end
      end
    end
  end
end
