class User < ApplicationRecord
  has_secure_password
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  has_many :comments
  has_many :posts
  has_many :categories, through: :posts

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

end
