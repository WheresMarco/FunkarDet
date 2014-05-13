class GroupMember < ActiveRecord::Base
  belongs_to :group

  validates :name, presence: true, length: { minimum: 2 }
  validates :email, presence: true,
                    uniqueness: true,
                    format: {
                      with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9\.-]+\.[A-Za-z]+\Z/
                    }
end
