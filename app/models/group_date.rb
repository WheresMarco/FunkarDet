class GroupDate < ActiveRecord::Base
  belongs_to :group
  has_many :group_date_attendances

  validates :name, presence: true, length: { minimum: 2 }
  validates :place, presence: true, length: { minimum: 2 }
end
