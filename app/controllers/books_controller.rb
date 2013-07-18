# -*- encoding : utf-8 -*-
class BooksController < ApplicationController
  def new
    @book = Book.new
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


  private


    def book_params
      params.require(:book).permit!
    end
end
