class Book < ApplicationRecord
  include ShoppingCart::Concerns::Models::Product
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :categories
  has_many :images, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :title, :description, :price, :publication_year,
            :dimensions, :materials, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: { case_sensitive: false }
  validates :publication_year, inclusion: { in: 1969..Date.today.year }

  paginates_per 12

  scope :best_seller, ->(category) do
    return Book.none unless Category.pluck(:name).include?(category)
    return Category.find_by(name: category).books.first unless ShoppingCart::LineItem.exists?
    ShoppingCart::LineItem.select("shopping_cart_line_items.product_id, sum(quantity) as total_quantity")
      .joins(product: :categories).where(categories: { name: category })
      .joins(:order).where(shopping_cart_orders: { state: 'delivered' })
      .group('shopping_cart_line_items.product_id').order('total_quantity DESC').first.product
  end

  scope :popular_first_ids, -> do
    return Book.none unless ShoppingCart::LineItem.exists?
    ShoppingCart::LineItem.select("line_items.product_id, sum(quantity) as total_quantity")
      .joins(:product)
      .joins(:order).where(orders: { state: 'delivered' })
      .group('line_items.product_id').order('total_quantity DESC').map(&:book_id)
  end
end
