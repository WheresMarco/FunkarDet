class User < ActiveRecord::Base
  has_secure_password
  has_many :groups

  validates :username, presence: true,
                       uniqueness: true

  validates :email, presence: true,
                    uniqueness: true,
                    format: {
                      with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9\.-]+\.[A-Za-z]+\Z/
                    }

  before_save :downcase_username, :downcase_email

  def downcase_username
    self.username = username.downcase
  end

  def downcase_email
    self.email = email.downcase
  end
end
