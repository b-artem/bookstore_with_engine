module ShoppingCart
  module Concerns
    module Controllers
      module ApplicationController
        extend ActiveSupport::Concern

        included do
          before_action :set_cart

          protected

            def set_cart
              @cart = ShoppingCart::Cart.find(session[:cart_id])
            rescue ActiveRecord::RecordNotFound
              @cart = ShoppingCart::Cart.create
              session[:cart_id] = @cart.id
            end
        end
      end
    end
  end
end
