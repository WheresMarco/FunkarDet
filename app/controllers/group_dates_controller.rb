class GroupDatesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
  end

  def new
    @group = Group.find(params[:group_id])
    @group_date = @group.group_dates.new
  end

  def create
    @group = Group.find(params[:group_id])
    @group_date = @group.group_dates.new(group_date_params)

    if @group_date.save
      flash[:success] = "Added group date."
      redirect_to group_group_dates_path
    else
      flash[:error] = "Threre was a problem adding that group date."
      render action: :new
    end
  end

  private
  def group_date_params
    params[:group_date].permit(:name)
  end
end
