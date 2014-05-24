class RemoveGroupDateAttendance < ActiveRecord::Migration
  def change
    drop_table :group_date_attendance
  end
end
