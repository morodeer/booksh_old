# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:show]
  before_filter :correct_user, only: [:edit, :update]

  respond_to :json, :html

  def new
    @user = User.new
  end

  def showme
    if signed_in?
      @user = current_user
      render 'show'
    else
      render 'static_pages/home'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to @user, success: "Welcome!"
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by_id(params[:id])
    respond_with(@user) do |format|
      format.json { render @user}
    end
  end

  def edit
		@user = User.find_by_id(params[:id])
  end

  def update
    if @user.update_attributes(user_params)
      sign_in @user
      redirect_to @user, success: "Profile updated"
    end
  end

  def index
    @users ||= User.paginate(page: params[:page])

  end

  def friends

    @user = params[:id].present? ? User.find_by_id(params[:id]) : current_user

    @friends = true;
    @users = @user.friends.paginate(page: params[:page])
    render 'index'

  end

  def search_friends
    if params[:user_id].present?
      @user = User.find_by_id(params[:user_id])
    else
      @user = current_user
    end
    query = params[:query]

    if query.length < 2
      @users = @user.friends.first(20)
    else
      @users = User.search conditions: {name: query}, with: {friend_ids: @user.id}
    end
    respond_to do |format|
      format.json {render json: @users.to_json(methods: :avatar_thumb_filename)}
    end
  end

  def search
      query = params[:query]
      if query.length < 2
        @users = User.first(20);
      else
        @users = User.search conditions: {name: query}
      end
      respond_to do |format|
        format.json {render json: @users.to_json(methods: :avatar_thumb_filename)}
      end
  end

  def unfriend
    @user = User.find_by_id(params[:id])
    if current_user?(@user)
      respond_with do |format|
        format.html {
          redirect_to @user
        }
        format.json {
          render json: [false].to_json
        }
      end
    else
      respond_with(current_user.unfriend(@user)) do |format|
        format.html {
          redirect_to @user
        }
        format.json {
          render
        }
      end
    end
  end

  def decline_friendship
    @user = User.find_by_id(params[:id])
    respond_with(current_user.decline_friendship_from(@user)) do |format|
      format.html {
        redirect_to @user
      }
      format.json {
        render
      }
    end
  end

  def accept_friendship
    @user = User.find_by_id(params[:id])
    respond_with(current_user.accept_friendship_from(@user)) do |format|
      format.html {
        redirect_to @user
      }
      format.json {
        render
      }
    end
  end

  def recall_friendship
    @user = User.find_by_id(params[:id])
    respond_with(current_user.recall_friendship_request_with(@user)) do |format|
      format.html {
        redirect_to @user
      }
      format.json {
        render
      }
    end
  end

  def request_friendship
    @user = User.find_by_id(params[:id])
    respond_with(current_user.request_friendship_with(@user)) do |format|
      format.html {
        redirect_to @user
      }
      format.json {
        render
      }
    end
  end

  def auth
    response = signed_in? ? 'true' : 'false'
    respond_with(response)
  end


  private
    def user_params
      params.require(:user).permit(
          :username,:email,:password,:password_confirmation,
          :first_name,:last_name,:city,:geo_coordinates, :avatar)
    end


    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
