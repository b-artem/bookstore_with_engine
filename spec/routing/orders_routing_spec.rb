require "rails_helper"

RSpec.describe ShoppingCart::Orders::OrdersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "shopping_cart/orders").to route_to("shopping_cart/orders/orders#index")
    end

    it "routes to #show" do
      expect(:get => "shopping_cart/orders/1").to route_to("shopping_cart/orders/orders#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "shopping_cart/orders").to route_to("shopping_cart/orders/orders#create")
    end

    it "routes to #destroy" do
      expect(:delete => "shopping_cart/orders/1").to route_to("shopping_cart/orders/orders#destroy", :id => "1")
    end
  end
end
