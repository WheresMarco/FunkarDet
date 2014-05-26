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
      flash[:success] = t('flash.member.added-member')
      redirect_to group_path(params[:group_id])
    else
      flash[:error] = t('flash.member.added-member-error')
      render action: :new
    end
  end

  def edit
    @group_member = @group.group_members.find(params[:id])
  end

  def update
    @group_member = @group.group_members.find(params[:id])

    if @group_member.update_attributes(group_member_params)
      flash[:success] = t('flash.member.saved-member')
      redirect_to group_path(params[:group_id])
    else
      flash[:error] = t('flash.member.saved-member-error')
      render action: :edit
    end
  end

  def destroy
    @group_member = @group.group_members.find(params[:id])

    if @group_member.destroy
      flash[:success] = t('flash.member.delete-member')
    else
      flash[:error] = t('flash.member.delete-member-error')
    end

    redirect_to group_group_members_path(params[:group_id])
  end

  def url_options
    { group_id: params[:group_id] }.merge(super)
  end

  private
  def find_group
    @group = current_user.groups.find(params[:group_id])
  end

  def group_member_params
    params[:group_member].permit(:name, :email)
  end
end
