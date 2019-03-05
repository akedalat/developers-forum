class Post < ApplicationRecord

  has_many :comments
  belongs_to :category
  belongs_to :user
  
end
