class Api::BooksController < ApplicationController
  respond_to :json

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
    respond_with(@book) do |format|
      format.json {render @book.to_json}
    end
  end

  def index
    @books = Book.paginate(page: params[:page])
    respond_with(@books) do |format|
      format.json { render @books.to_json}
    end
  end

  def search

    if params[:query].present?

      if params[:author_id].present?
        @books = Book.search conditions: {title: params[:query], author_id: params[:author_id]}
        respond_to do |format|
          format.html
          format.json {render json: @books}
        end
      end
    else
      if params[:author_id].present?
        @books = Book.search conditions: {author_id: params[:author_id]}
        respond_to do |format|
          format.html
          format.json {render json: @books}
        end
      end
    end

  end


  private


  def book_params
    params.require(:book).permit!
  end
end
