class CreateGroupDateAttendance < ActiveRecord::Migration
  def self.up
    create_table 'group_date_attendance', :id => false do |t|
      t.column :group_dates_id, :integer
      t.column :user_id, :integer
    end
  end

  def self.down
    drop_table 'group_date_attendances'
  end
end
