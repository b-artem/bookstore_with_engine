class ShippingMethodDecorator < Draper::Decorator
  delegate_all

  def terms
    I18n.t('orders.checkout.delivery.term', days_min: days_min, days_max: days_max)
  end

  def price
    h.number_to_currency(object.price)
  end
end
