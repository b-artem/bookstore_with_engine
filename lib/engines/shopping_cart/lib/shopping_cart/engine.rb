require 'aasm'
require 'bootstrap-sass'
require 'cancancan'
require 'coffee-rails'
require 'country_select'
require 'devise'
require 'draper'
require 'font-awesome-rails'
require 'jquery-rails'
require 'haml-rails'
require 'sass-rails'
require 'simple_form'
require 'turbolinks'
require 'wicked'
require_relative '../concerns/controllers/cart_support'
require_relative '../concerns/models/user'
require_relative '../concerns/models/product'

module ShoppingCart
  class Engine < ::Rails::Engine
    isolate_namespace ShoppingCart

    config.to_prepare do
      Dir.glob(Engine.root + 'app/decorators/**/*_decorator*.rb').each do |c|
        require_dependency(c)
      end
    end

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
      g.assets false
      g.helper false
    end
  end
end
