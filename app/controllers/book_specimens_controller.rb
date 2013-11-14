# -*- encoding : utf-8 -*-
class BookSpecimensController < ApplicationController

  before_filter :signed_in_user, only: [:new, :create]

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
    @user = @specimen.owner
    render 'books/show'
  end

  private

    def signed_in_user
      unless user_signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in"
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
