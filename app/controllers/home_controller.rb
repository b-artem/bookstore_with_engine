class HomeController < ApplicationController
  def index
    @latest_books = Book.order('created_at DESC').limit(3)
    @best_sellers = []
    @categories.each { |category| @best_sellers << Book.best_seller(category.name) }
  end
end
