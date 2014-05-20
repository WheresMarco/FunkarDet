class GroupDateAttendance < ActiveRecord::Base
  belongs_to :user
  belongs_to :group_date
end
