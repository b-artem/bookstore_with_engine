class Cart < ApplicationRecord
  include Validations
  belongs_to :coupon, optional: true
  has_many :line_items, dependent: :destroy

  def add_product(product, quantity)
    return unless positive_integer?(quantity)
    current_item = line_items.find_by(book_id: product.id)
    if current_item
      current_item.quantity += Integer(quantity)
    else
      current_item = line_items.build(book_id: product.id, quantity: quantity,
                                      price: product.price)
    end
    current_item
  end

  def subtotal
    return 0 unless line_items.exists?
    line_items.sum(&:subtotal)
  end

  def total
    return subtotal unless coupon
    subtotal * (1 - coupon.discount/100)
  end

  def products_quantity
    return 0 unless line_items.exists?
    line_items.sum(&:quantity)
  end
end
