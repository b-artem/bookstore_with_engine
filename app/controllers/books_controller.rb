class BooksController < ApplicationController
  load_and_authorize_resource
  decorates_assigned :book

  def index
    if sort_condition == 'popularity'
      books = @books.where(id: Book.popular_first_ids)
    elsif category_name == 'all'
      books = @books.order(sort_condition + ' ' + sort_direction)
    else
      books = Category.find_by(name: category_name)
        .books.order(sort_condition + ' ' + sort_direction)
    end
    @books = books.page(params[:page])
  end

  def show
  end

  private

    def category_name
      Category.pluck(:name).include?(params[:category]) ? params[:category] : 'all'
    end

    def sort_condition
      return 'popularity' if params[:sort_by] == 'popularity'
      Book.column_names.include?(params[:sort_by]) ? params[:sort_by] : 'created_at'
    end

    def sort_direction
      %w[ASC DESC].include?(params[:sort_direction]) ? params[:sort_direction] : "DESC"
    end
end
