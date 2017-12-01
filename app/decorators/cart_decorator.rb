class CartDecorator < Draper::Decorator
  delegate_all

  def subtotal
    h.number_to_currency(object.subtotal)
  end

  def total
    h.number_to_currency(object.total)
  end

  def discount
    h.number_to_currency(object.total - object.subtotal)
  end
end
