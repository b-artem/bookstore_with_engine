module ShoppingCart
  class ApplicationController < ::ApplicationController
    protect_from_forgery with: :exception
    include Concerns::Controllers::ApplicationController

    def current_main_app_user
      public_send "current_#{ShoppingCart.user_class.to_s.downcase}"
    end

    def authenticate_main_app_user!
      public_send "authenticate_#{ShoppingCart.user_class.to_s.downcase}!"
    end

    def current_ability
      @current_ability ||= ShoppingCart::Ability.new(current_main_app_user, session)
    end
  end
end
