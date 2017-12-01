class ReviewsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :book
  load_and_authorize_resource :review, through: :book

  def create
    @review.user = current_user
    if @review.save
      redirect_to @book, notice: t('.success')
    else
      redirect_to @book, flash: { errors: @review.errors }
    end
  end

  private

    def review_params
      params.require(:review).permit(:title, :text, :score)
    end
end
