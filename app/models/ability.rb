class Ability
  include CanCan::Ability

  def initialize(user, session = nil)
    user ||= User.new
    if user.role == 'admin'
      can :access, :rails_admin
      can :dashboard
      can :manage, :all
    else
      return unless session
      can :read, Book
      can :create, Review
      can :read, Review, status: 'approved'
      can :manage, Cart, id: session[:cart_id]
      can :manage, LineItem, cart: { id: session[:cart_id] }
      can :manage, Order, id: session[:order_id]
      can :read, Order, user_id: user.id
      can :manage, Address, order_id: session[:order_id]
    end
  end
end
