module CurrentOrder

  private

    def set_current_order(order)
      session[:order_id] = order.id
    end

    def current_order
      Order.uncached do
        Order.find(session[:order_id])
      end
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = t('order_was_not_found', order_id: session[:order_id])
    end

    def empty_current_order
      session.delete :order_id
    end
end
