# -*- encoding : utf-8 -*-
class BooksController < ApplicationController
  respond_to :json, :html

  def new
    @book = Book.new
    @book.authors = [Author.new]
  end

  def create

    authors = params[:book][:authors_attributes]
    params[:book].delete :authors_attributes
    @book = Book.create!(book_params)
    authors.each do |a|
      author = Author.find_by_id(a[1][:id])
      author.own!(@book)
    end
    redirect_to @book
  end

  def show
    @book = Book.find_by_id(params[:id])
  end

  def index
    @books = Book.paginate(page: params[:page])
  end

  def search

    if params[:query].present?

      if params[:author_id].present?
        @books = Book.search conditions: {title: params[:query], author_id: params[:author_id]}
      end
    else
      if params[:author_id].present?
        @books = Book.search conditions: {author_id: params[:author_id]}
      end
    end

  end


  private


    def book_params
      params.require(:book).permit!
    end
end
