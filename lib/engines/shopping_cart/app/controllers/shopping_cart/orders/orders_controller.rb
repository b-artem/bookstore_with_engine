require 'order_service'

class Orders::OrdersController < ApplicationController
  include CurrentOrder
  before_action :authenticate_user!
  before_action :ensure_cart_isnt_empty, only: [:create]
  load_and_authorize_resource through: :current_user, except: :create
  authorize_resource only: :create

  def index
    @orders = @orders.where(state: state_filter).order('completed_at DESC')
  end

  def show
  end

  def create
    @order = current_user.orders.create(coupon: @cart.coupon)
    set_current_order(@order)
    Services::OrderService.new(order: @order, cart: @cart, session: session)
                          .set_order_from_cart
    redirect_to order_checkout_index_path(@order)
  end

  private

    def state_filter
      return 'in_queue' if !params[:state] || !Order.aasm.states.map(&:name)
                                                .include?(params[:state].to_sym)
      params[:state]
    end
end
