class ChangeGroupAttendenceIdNameThing < ActiveRecord::Migration
  def change
    rename_column :group_date_attendance, :group_dates_id, :group_date_id
  end
end
