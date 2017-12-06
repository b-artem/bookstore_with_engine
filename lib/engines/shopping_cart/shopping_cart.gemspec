$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "shopping_cart/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "shopping_cart"
  s.version     = ShoppingCart::VERSION
  s.authors     = ["b-artem"]
  s.email       = ["artem@example.com"]
  s.homepage    = "https://github.com/b-artem/cart_engine"
  s.summary     = "Shopping cart and checkout flow"
  s.description = "Adds shopping cart and checkout flow to an app"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency 'aasm', '~> 4.12', '>= 4.12.3'
  s.add_dependency 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
  s.add_dependency 'cancancan', '~> 2.1', '>= 2.1.1'
  s.add_dependency 'coffee-rails', '~> 4.2', '>= 4.2.2'
  s.add_dependency 'country_select', '~> 3.1'
  s.add_dependency 'devise', '~> 4.3'
  s.add_dependency 'draper', '~> 3.0', '>= 3.0.1'
  s.add_dependency 'font-awesome-rails', '~> 4.7', '>= 4.7.0.2'
  s.add_dependency 'haml-rails', '~> 1.0'
  s.add_dependency 'jquery-rails', '~> 4.3', '>= 4.3.1'
  s.add_dependency 'rails', '~> 5.1'
  s.add_dependency 'rectify', '~> 0.10.0'
  s.add_dependency 'sass-rails', '~> 5.0'
  s.add_dependency 'simple_form', '~> 3.5'
  s.add_dependency 'turbolinks', '~> 5.0', '>= 5.0.1'
  s.add_dependency 'wicked', '~> 1.3', '>= 1.3.2'

  s.add_development_dependency 'capybara', '~> 2.13'
  s.add_development_dependency 'capybara-webkit', '~> 1.14'
  s.add_development_dependency 'database_cleaner', '~> 1.6', '>= 1.6.2'
  s.add_development_dependency 'factory_bot_rails', '~> 4.8', '>= 4.8.2'
  s.add_development_dependency 'faker', '~> 1.8', '>= 1.8.4'
  s.add_development_dependency 'pry-rails', '~> 0.3.6'
  s.add_development_dependency 'rack_session_access', '~> 0.1.1'
  s.add_development_dependency 'rspec-rails', '~> 3.7', '>= 3.7.1'
  s.add_development_dependency 'selenium-webdriver', '~> 3.7'
  s.add_development_dependency 'shoulda-matchers', '~> 3.1', '>= 3.1.2'
  s.add_development_dependency 'sqlite3', '~> 1.3', '>= 1.3.13'
end
