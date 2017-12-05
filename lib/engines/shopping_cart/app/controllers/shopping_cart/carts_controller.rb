class CartsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
  authorize_resource

  def show
  end

  def update
    coupon = Coupon.find_by(code: params[:cart][:coupon][:code])
    return redirect_to(@cart, alert: t('.fail')) unless coupon
    @cart.update(coupon: coupon)
    redirect_to @cart, notice: t('.success')
  end

  private

    def invalid_cart
      logger.error t('.access_ivalid_cart', cart_id: params[:id])
      redirect_back fallback_location: root_path, notice: t('.invalid_cart')
    end
end
