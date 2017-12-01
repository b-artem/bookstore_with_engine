require_dependency "shopping_cart/application_controller"
require_relative '../../../services/shopping_cart/order_service'

module ShoppingCart
  class Orders::OrdersController < ApplicationController
    include Concerns::Controllers::CurrentOrder
    before_action :authenticate_main_app_user!
    before_action :ensure_cart_isnt_empty, only: [:create]
    load_and_authorize_resource class: 'ShoppingCart::Order', through: :current_main_app_user, except: :create
    authorize_resource class: 'ShoppingCart::Order', only: :create

    def index
      @orders = @orders.where(state: state_filter).order('completed_at DESC')
    end

    def show
    end

    def create
      @order = current_main_app_user.orders.create(coupon: @cart.coupon)
      set_current_order(@order)
      ShoppingCart::Services::OrderService.new(order: @order, cart: @cart, session: session)
                            .set_order_from_cart
      redirect_to order_checkout_index_path(@order)
    end

    private

      def ensure_cart_isnt_empty
        return if @cart.line_items.exists?
        redirect_to(main_app_products_url, notice: t('shopping_cart.cart_is_empty'))
      end

      def state_filter
        return 'in_queue' if !params[:state] || !Order.aasm.states.map(&:name)
                                                  .include?(params[:state].to_sym)
        params[:state]
      end

      def main_app_products_url
        main_app.public_send(ShoppingCart.product_class.to_s.pluralize(5).downcase + '_url')
      end
  end
end
