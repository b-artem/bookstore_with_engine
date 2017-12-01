module CurrentCart

  private

    def set_cart
      @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end

    def ensure_cart_isnt_empty
      redirect_to(books_url, notice: t('cart_is_empty')) unless @cart.line_items.exists?
    end
end
