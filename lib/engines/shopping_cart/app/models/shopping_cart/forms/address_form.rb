class Forms::AddressForm < Rectify::Form

  attribute :type, String
  attribute :first_name, String
  attribute :last_name, String
  attribute :address, String
  attribute :city, String
  attribute :zip, String
  attribute :country, String
  attribute :phone, String
  attribute :order_id, Integer

  validates :type, :first_name, :last_name, :address, :city, :zip, :country,
            :phone, presence: true, if: :need_shipping_address?
  validates :type, inclusion: { in: %w(BillingAddress ShippingAddress) }
  validates :first_name, :last_name,
            format: { with: /\A[a-zA-Z]+\z/,
                      message: I18n.t('models.forms.address_form.only_letters') },
            length: { maximum: 49 }, if: :need_shipping_address?
  validates :address,
            format: { with: /\A[A-Za-z0-9, -]+\z/,
                      message: I18n.t('models.forms.address_form.address_symbols') },
            length: { maximum: 49 }, if: :need_shipping_address?
  validates :city, :country,
            format: { with: /\A[A-Z a-z]+\z/,
                      message: I18n.t('models.forms.address_form.city_symbols') },
            length: { maximum: 49 }, if: :need_shipping_address?
  validates :zip,
            format: { with: /\A[0-9-]+\z/,
                      message: I18n.t('models.forms.address_form.zip_symbols') },
            length: { maximum: 10 }, if: :need_shipping_address?
  validates :phone,
            format: { with: /\A\+{1}[0-9]+\z/,
                      message: I18n.t('models.forms.address_form.phone_symbols') },
            length: { maximum: 15 }, if: :need_shipping_address?

  def need_shipping_address?
    return if type == 'ShippingAddress' && context.use_billing_address_as_shipping
    true
  end
end
