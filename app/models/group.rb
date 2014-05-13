class Group < ActiveRecord::Base
  belongs_to :user
  has_many :group_dates

  validates :name, presence: true,
                   length: { minimum: 3 }
end
