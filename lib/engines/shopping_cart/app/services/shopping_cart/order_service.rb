module Services
  class OrderService
    def initialize(order:, cart:, session:)
      @order = order
      @cart = cart
      @session = session
    end

    def set_order_from_cart
      add_line_items_to_order_from_cart
      destroy_cart
    end

    private

      def add_line_items_to_order_from_cart
        @cart.line_items.each do |item|
          item.update(cart_id: nil, order_id: @order.id)
        end
      end

      def destroy_cart
        Cart.destroy(@session[:cart_id])
        @session.delete :cart_id
        @session.delete :discount_id
      end
  end
end
