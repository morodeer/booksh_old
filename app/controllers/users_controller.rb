class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:show]
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user
      sign_in @user
      redirect_to @user, success: "Welcome!"
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  private
    def user_params
      params[:user][:username].downcase!
      params.require(:user).permit(:username,:email,:password,:password_confirmation)
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in"
      end
    end
end
