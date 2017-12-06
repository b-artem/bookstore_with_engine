module ShoppingCart::Concerns::Models::Product
  extend ActiveSupport::Concern

  included do
    has_many :line_items, class_name: 'ShoppingCart::LineItem'
    before_destroy :ensure_not_referenced_by_any_line_item

    protected

      def ensure_not_referenced_by_any_line_item
        if line_items.exists?
          errors.add(:base, I18n.t('shopping_cart.models.product.referenced_by_line_items'))
          throw :abort
        end
      end
  end
end
