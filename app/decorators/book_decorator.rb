class BookDecorator < Draper::Decorator
  delegate_all
  decorates_association :authors

  def authors_names
    authors.map(&:name).join(', ')
  end

  def short_description(length = 500)
    h.truncate(description, length: length)
  end

  def full_description
    h.truncate(description, length: 10000).gsub(/\s+/, ' ')
  end

  def price
    h.number_to_currency(object.price)
  end
end
