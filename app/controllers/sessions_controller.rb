class SessionsController < ApplicationController


  def new
      if signed_in?
        redirect_to current_user
      end
  end

  def create
    user = User.find_by_username(params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid username/password combination'
      render 'new'
    end

  end

  def destroy
    sign_out
    redirect_to root_url
  end

  private
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in"
      end
    end
end
