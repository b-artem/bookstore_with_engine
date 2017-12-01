class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ShoppingCart::Concerns::Controllers::ApplicationController
end
