# -*- encoding : utf-8 -*-
class BookSpecimensController < ApplicationController

  def new
    @specimen = BookSpecimen.new
    @book = Book.new
  end

  def create
    if params[:book_id].present?
      book = Book.find_by_id(params[:book_id])
      if book
        @specimen = current_user.obtain!(book)
        redirect_to @specimen
      end
    else
      redirect_to new_book_specimen_path, error: 'No book_id specified'
    end

  end


  def show
    @specimen = BookSpecimen.find_by_id(params[:id])
    @book = @specimen.book
    @user = @specimen.user
  end

end
