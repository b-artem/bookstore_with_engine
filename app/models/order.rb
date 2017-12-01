class Order < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :shipping_method, optional: true
  belongs_to :coupon, optional: true
  has_one :billing_address, dependent: :destroy
  has_one :shipping_address, dependent: :destroy
  has_many :line_items, dependent: :destroy

  after_create :generate_number

  aasm column: 'state' do
    state :in_progress, initial: true
    state :in_queue, :in_delivery, :delivered, :canceled

    event :pay do
      transitions from: :in_progress, to: :in_queue
      after do
        update_attributes(completed_at: Time.now)
      end
    end
  end

  def shipping_address
    return super unless self[:use_billing_address_as_shipping]
    billing_address
  end

  def subtotal
    return 0 unless line_items.exists?
    line_items.sum(&:subtotal)
  end

  def total
    shipping_price = (shipping_method ? shipping_method.price : 0)
    subtotal - discount + shipping_price
  end

  def discount
    return 0 unless coupon
    subtotal * coupon.discount / 100
  end

  private

    def generate_number
      number = id.to_s.rjust(9, 'R00000000')
      update_attributes(number: number)
    end
end
