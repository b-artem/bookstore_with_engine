module ShoppingCart
  module ApplicationHelper
    def product_path(product)
      main_app.public_send(ShoppingCart.product_class.to_s.downcase + '_path',
                           product)
    end

    def products_path
      main_app.public_send(ShoppingCart.product_class.to_s.pluralize(5)
                                                     .downcase + '_path')
    end
  end
end
