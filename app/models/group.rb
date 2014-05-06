class Group < ActiveRecord::Base
  has_many :group_dates

  validates :name, presence: true,
                   length: { minimum: 3 }
end
