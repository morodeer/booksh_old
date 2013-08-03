class AuthorsController < ApplicationController
  def show

  end

  def new
		@author = Author.new
  end

  def index
    @authors = Author.paginate(page: params[:page])
  end

  def search
    if params[:query].present?

      @authors = Author.search params[:query]

    else
    @authors = Author.paginate(page: params[:page])
    end
  respond_to do |format|
    format.html
    format.json { render json: @authors }
  end
    end

end
