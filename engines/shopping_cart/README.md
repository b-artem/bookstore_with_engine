# Shopping Cart
Adds shopping cart and checkout flow to your app.

## Usage
1. Your app should have classes that represent users
and products. You can name these classes whatever you want, although you need to define
user_class and product_class in `app/config/initializers/shopping_cart.rb`, e.g.:
```ruby
ShoppingCart.product_class = 'Book'
ShoppingCart.user_class = 'User'
```

2. User have to respond to #email method.
Product have to respond to #title, #price, #cover_image, and #short_description methods.

3. Include the following line in your `application_controller.rb`:
```ruby
include ShoppingCart::Concerns::Controllers::ApplicationController
```
4. Include the following line in your user model, e.g. `user.rb`:
```ruby
include ShoppingCart::Concerns::Models::User
```

5. Engine expects your application to call flash[:notice] and flash[:alert] as appropriate
to show notifications. For example, in your application layout:
```ruby
%p#notice= notice
%p#alert= alert
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'shopping-cart'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install shopping-cart
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
