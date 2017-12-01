class LineItemDecorator < Draper::Decorator
  delegate_all

  def price
    h.number_to_currency(object.price)
  end

  def subtotal
    h.number_to_currency(object.subtotal)
  end
end
