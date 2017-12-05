class AddressDecorator < Draper::Decorator
  delegate_all

  def full_name
    first_name + ' ' + last_name
  end

  def city_zip
    city + ' ' + zip
  end

  def country
    country = ISO3166::Country[object.country]
    country.translations[I18n.locale.to_s] || country.name
  end
end
