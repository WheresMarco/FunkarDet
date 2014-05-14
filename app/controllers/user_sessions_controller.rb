class UserSessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_username((params[:username]).downcase)

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      # If the user is an organizer, redirect to index.
      # Else make the user select a member from group_members
      if user.organizer
        flash[:success] = "Thanks for logging in!"
        redirect_to groups_path
      else
        redirect_to select_user_path
      end
    else
      flash[:error] = "There was a problem logging in. Please check your username and password."
      render action: 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    reset_session
    redirect_to root_path, notice: "You have been logged out."
  end

  def select_user
    user = User.find_by_id(session[:user_id])
    @groups = Group.find_by_user_id(user.id)
  end

  def select_user_post
    session[:group_member_id] = params[:group_member]
    group_member = GroupMember.find_by_id(session[:group_member_id])

    redirect_to group_path(group_member.group_id)
  end
end
