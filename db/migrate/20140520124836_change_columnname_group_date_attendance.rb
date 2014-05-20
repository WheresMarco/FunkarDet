class ChangeColumnnameGroupDateAttendance < ActiveRecord::Migration
  def change
    rename_column 'group_date_attendances', :user_id, :group_member_id
  end
end
