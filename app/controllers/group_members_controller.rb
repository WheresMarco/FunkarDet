class GroupMembersController < ApplicationController
  before_action :require_user
  before_action :find_group
  
  def index
  end

  private
  def find_group
    @group = current_user.groups.find(params[:group_id])
  end

  def group_date_params
    params[:group_date].permit(:name, :place)
  end
end
