class Coupon < ApplicationRecord
  has_many :carts
  has_many :orders

  validates :code, :discount, :valid_until, presence: true
  validates :code,
            format: { with: /\A[a-zA-Z0-9]+\z/,
                      message: I18n.t('models.coupon.coupon_symbols') },
            length: { minimum: 8, maximum: 12 }
  validates :discount,
            numericality: { greater_than_or_equal_to: 0.1,
                            less_than_or_equal_to: 100 }
end
