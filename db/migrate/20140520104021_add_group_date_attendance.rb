class AddGroupDateAttendance < ActiveRecord::Migration
  def change
    create_table 'group_date_attendances', :id => false do |t|
      t.column :group_date_id, :integer
      t.column :user_id, :integer
      t.column :answer, :integer
    end
  end
end
