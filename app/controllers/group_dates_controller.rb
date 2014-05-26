class GroupDatesController < ApplicationController
  before_action :require_user
  before_action :find_group

  def index
  end

  def new
    @group_date = @group.group_dates.new
  end

  def create
    @group_date = @group.group_dates.new(group_date_params)

    if @group_date.save
      flash[:success] = t('flash.group.added-date')
      redirect_to groups_path
    else
      flash[:error] = t('flash.group.added-date-error')
      render action: :new
    end
  end

  def edit
    @group_date = @group.group_dates.find(params[:id])
  end

  def update
    @group_date = @group.group_dates.find(params[:id])

    if @group_date.update_attributes(group_date_params)
      flash[:success] = t('flash.group.saved-date')
      redirect_to groups_path
    else
      flash[:error] = t('flash.group.saved-date-error')
      render action: :edit
    end
  end

  def destroy
    @group_date = @group.group_dates.find(params[:id])
    if @group_date.destroy
      flash[:success] = t('flash.group.delete-date')
    else
      flash[:error] = t('flash.group.delete-date-error')
    end
    redirect_to "/"
  end

  def attend_date
    if !GroupDateAttendance.exists?(:group_date_id => params[:group_date_id], :group_member_id => params[:format])
      @group_date_attend = GroupDateAttendance.new(group_date_id: params[:group_date_id], group_member_id: params[:format], answer: params[:answer])

      if @group_date_attend.save
        flash[:success] = t('flash.group.attending-date')
        redirect_to groups_path
      else
        flash[:error] = t('flash.group.attending-date-error')
        redirect_to groups_path
      end
    else
      @group_date_attend = GroupDateAttendance.find_by(group_date_id: params[:group_date_id], group_member_id: params[:format])

      if @group_date_attend.update(answer: params[:answer])
        flash[:success] = t('flash.group.attending-date')
        redirect_to groups_path
      else
        flash[:error] = t('flash.group.attending-date-error')
        redirect_to groups_path
      end
    end
  end

  def url_options
    { group_id: params[:group_id] }.merge(super)
  end

  private
  def find_group
    @group = current_user.groups.find(params[:group_id])
  end

  def set_group_member
    @group_member ||= GroupMember.find_by_id(session[:group_member_id]) if session[:group_member_id]
  end

  def group_date_params
    params[:group_date].permit(:name, :description, :from_date, :to_date, :place)
  end
end
