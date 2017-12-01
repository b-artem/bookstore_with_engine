class Book < ApplicationRecord
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :categories
  has_many :images, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :price, :publication_year,
            :dimensions, :materials, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: { case_sensitive: false }
  validates :publication_year, inclusion: { in: 1969..Date.today.year }

  paginates_per 12

  scope :best_seller, ->(category) do
    return Book.none unless Category.pluck(:name).include?(category)
    return Category.find_by(name: category).books.first unless LineItem.exists?
    LineItem.select("line_items.book_id, sum(quantity) as total_quantity")
      .joins(book: :categories).where(categories: { name: category })
      .joins(:order).where(orders: { state: 'delivered' })
      .group('line_items.book_id').order('total_quantity DESC').first.book
  end

  scope :popular_first_ids, -> do
    return Book.none unless LineItem.exists?
    LineItem.select("line_items.book_id, sum(quantity) as total_quantity")
      .joins(:book)
      .joins(:order).where(orders: { state: 'delivered' })
      .group('line_items.book_id').order('total_quantity DESC').map(&:book_id)
  end

  private

    def ensure_not_referenced_by_any_line_item
      if line_items.exists?
        errors.add(:base, I18n.t('models.book.referenced_by_line_items'))
        throw :abort
      end
    end
end
