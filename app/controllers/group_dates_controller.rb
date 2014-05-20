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
      flash[:success] = "Added group date."
      redirect_to group_group_dates_path
    else
      flash[:error] = "Threre was a problem adding that group date."
      render action: :new
    end
  end

  def edit
    @group_date = @group.group_dates.find(params[:id])
  end

  def update
    @group_date = @group.group_dates.find(params[:id])

    if @group_date.update_attributes(group_date_params)
      flash[:success] = "Saved group date."
      redirect_to groups_path
    else
      flash[:error] = "That grup date could not be saved."
      render action: :edit
    end
  end

  def destroy
    @group_date = @group.group_dates.find(params[:id])
    if @group_date.destroy
      flash[:success] = "Group date was deleted."
    else
      flash[:error] = "Threre was a problem deleting that group date."
    end
    redirect_to "/"
  end

  def attend_date
    if !GroupDateAttendance.exists?(:group_date_id => params[:group_date_id], :group_member_id => params[:format])
      @group_date_attend = GroupDateAttendance.new(group_date_id: params[:group_date_id], group_member_id: params[:format], answer: params[:answer])

      if @group_date_attend.save
        flash[:success] = "Saved answer."
        redirect_to groups_path
      else
        flash[:error] = "Threre was a problem saving your answer."
        redirect_to groups_path
      end
    else
      @group_date_attend = GroupDateAttendance.find_by(group_date_id: params[:group_date_id], group_member_id: params[:format])

      if @group_date_attend.update_attributes(answer: params[:answer])
        flash[:success] = "Saved answer."
        redirect_to groups_path
      else
        flash[:error] = "Threre was a problem saving your answer."
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
