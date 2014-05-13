class GroupMembersController < ApplicationController
  before_action :require_user
  before_action :find_group

  def index
  end

  def new
    @group_member = @group.group_members.new
  end

  def create
    @group_member = @group.group_members.new(group_member_params)

    if @group_member.save
      flash[:success] = "Added member."
      redirect_to group_group_members_path(params[:group_id])
    else
      flash[:error] = "Threre was a problem adding that member."
      render action: :new
    end
  end

  private
  def find_group
    @group = current_user.groups.find(params[:group_id])
  end

  def group_member_params
    params[:group_member].permit(:name, :email)
  end
end
