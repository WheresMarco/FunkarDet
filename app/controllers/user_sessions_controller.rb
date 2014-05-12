class UserSessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Thanks for logging in!"
      redirect_to groups_path
    else
      flash[:error] = "There was a problem logging in. Please check your username and password."
      render action: 'new'
    end
  end
end
