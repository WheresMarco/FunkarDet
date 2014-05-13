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
      redirect_to group_group_dates_path
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
    redirect_to group_group_dates_path
  end

  def url_options
    { group_id: params[:group_id] }.merge(super)
  end

  private
  def find_group
    @group = current_user.groups.find(params[:group_id])
  end

  def group_date_params
    params[:group_date].permit(:name, :place)
  end
end
