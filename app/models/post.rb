class Post < ApplicationRecord
validates :title, :content, presence: true

  has_many :comments
  belongs_to :category
  belongs_to :user

end
