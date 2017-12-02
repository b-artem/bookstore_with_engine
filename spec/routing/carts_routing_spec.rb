require "rails_helper"

RSpec.describe ShoppingCart::CartsController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(:get => "shopping_cart/carts/1").to route_to("shopping_cart/carts#show", :id => "1")
    end
  end
end
