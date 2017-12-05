module ShoppingCart
  class LineItem < ApplicationRecord
    belongs_to :product, class_name: ShoppingCart.product_class.to_s
    belongs_to :cart, optional: true
    belongs_to :order, optional: true

    validates :quantity, presence: true,
              numericality: { only_integer: true, greater_than_or_equal_to: 1  }

    def subtotal
      price * quantity
    end
  end
end
