class GroupsController < ApplicationController
  before_action :require_user
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :set_group_member, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    @groups = current_user.groups

    # Redirect to group page - dossen't work
    if !current_user.organizer
      if session[:group_member_id]
        redirect_to group_path(set_group_member.group_id)
      else
        redirect_to select_user_path
      end
    else
      redirect_to group_path(set_group_user.group_id)
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    if !current_user.organizer
      @group_dates_unanswerd = @group.group_dates.joins('LEFT JOIN group_date_attendances ON group_date_attendances.group_date_id = group_dates.id AND group_date_attendances.group_member_id = ' + @group_member.id.to_s).where('group_date_attendances.answer IS NULL')
      @number_of_group_dates_unanswerd = @group_dates_unanswerd.count
      @group_dates_answered = @group.group_dates.joins('INNER JOIN group_date_attendances ON group_date_attendances.group_date_id = group_dates.id AND group_date_attendances.group_member_id = ' + @group_member.id.to_s)
    else
      @group_dates_organizer = @group.group_dates.joins('LEFT JOIN group_date_attendances ON group_date_attendances.group_date_id = group_dates.id LEFT JOIN group_members ON group_date_attendances.group_member_id = group_members.id').group('group_dates.id')
    end
  end

  # GET /groups/new
  def new
    @group = current_user.groups.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = current_user.groups.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group }
      else
        format.html { render action: 'new' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = current_user.groups.find(params[:id])
    end

    def set_group_member
      @group_member ||= GroupMember.find_by_id(session[:group_member_id]) if session[:group_member_id]
    end

    def set_group_user
      @group_user = GroupsUsers.find_by_user_id(session[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :creation_date)
    end
end
