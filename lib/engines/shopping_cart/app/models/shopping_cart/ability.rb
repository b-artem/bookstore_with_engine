module ShoppingCart
  class Ability
    include CanCan::Ability

    def initialize(user, session = nil)
      user ||= ShoppingCart.user_class.new
      return unless session
      can :manage, Cart, id: session[:cart_id]
      can :manage, LineItem, cart: { id: session[:cart_id] }
      can :manage, Order, id: session[:order_id]
      can :read, Order, user_id: user.id
      can :manage, Address, order_id: session[:order_id]
    end
  end
end
