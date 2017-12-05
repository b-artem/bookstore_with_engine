class OrderDecorator < Draper::Decorator
  delegate_all

  def subtotal
    h.number_to_currency(object.subtotal)
  end

  def total
    h.number_to_currency(object.total)
  end

  def completed_at_long_date
    I18n.l(object.completed_at, format: :date_long)
  end

  def completed_at_short_date
    return I18n.t('orders.orders.index.not_completed') unless object.completed_at
    I18n.l(object.completed_at, format: :date_short)
  end

  def discount
    h.number_to_currency(-1 * object.discount)
  end

  def state
    I18n.t("orders.orders.filter.#{object.state}")
  end
end
