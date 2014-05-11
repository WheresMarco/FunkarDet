class GroupDate < ActiveRecord::Base
  belongs_to :group

  validates :name, presence: true, length: { minimum: 2 }
  validates :place, presence: true, length: { minimum: 2 }
end
