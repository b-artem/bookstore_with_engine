require_dependency "shopping_cart/application_controller"

module ShoppingCart
  class LineItemsController < ApplicationController
    load_and_authorize_resource only: %i[update destroy]
    authorize_resource only: :create

    def create
      product = ShoppingCart.product_class.find(params[:product_id])
      @line_item = @cart.add_product(product, params[:quantity])
      if @line_item.save
        redirect_back fallback_location: main_app.root_path, notice: t('.success')
      else
        redirect_back fallback_location: main_app.root_path, alert: t('.fail')
      end
    rescue
      redirect_back fallback_location: main_app.root_path,
                    alert: t('.enter_positive_integer')
    end

    def update
      respond_to do |format|
        if @line_item.update(line_item_params)
          format.js
        else
          format.js { redirect_to @cart }
        end
      end
    end

    def destroy
      @line_item.destroy
      redirect_to @cart, notice: t('.success')
    end

    private

      def line_item_params
        params.require(:line_item).permit(:quantity)
      end
  end
end
