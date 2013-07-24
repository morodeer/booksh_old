class AuthorsController < ApplicationController
  def show

  end

  def index
    @authors = Author.paginate(page: params[:page])
  end

  def search
    if params[:query].present?

      @authors = Author.search params[:query]
      respond_to do |format|
        format.html
        format.json { render json: @authors }
      end
    end
  else
    @authors = Author.paginate(page: params[:page])
  end
end
