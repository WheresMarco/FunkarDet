class AddAnswerToGroupDateAttendance < ActiveRecord::Migration
  def change
    add_column :group_date_attendance, :answer, :integer
  end
end
