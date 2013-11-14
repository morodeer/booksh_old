class Api::AuthorsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :update, :edit, :search]

  def show
    @author = Author.find_by_id(params[:id])
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new params.require(:author).permit(
                             :name, :real_name, :wiki_link
                         )

    if @author.save
      @author.make_photo_from_url params[:author][:photo_url]
      redirect_to @author
    else
      render 'new', error: 'Something wrong'
    end
  end

  def edit
    @author = Author.find_by_id(params[:id])
  end

  def update
    @author = Author.find_by_id(params[:id])

    puts params[:author]


    if @author.update_attributes(params.require(:author).permit(:name, :real_name, :wiki_link))
      @author.make_photo_from_url params[:photo_url]
      redirect_to @author
    else
      render 'edit', error: 'Something wrong'
    end
  end

  def index
    @authors = Author.paginate(page: params[:page])
  end





  def search
    query = params[:query]
    if query.length < 2
      @authors = Author.first(20);
    else
      @authors = Author.search conditions: {name: query}
    end
    respond_to do |format|
      format.json {render json: @authors.to_json(methods: :photo_thumb_filename)}
    end
  end


  private
  def signed_in_user
    unless user_signed_in?
      redirect_to signin_path
    end
  end

end
