class Tag < ApplicationRecord
  
  has_many :closet_tags
  has_many :closets, through: :closet_tags
  
  validates :tag_name, presence: true
  
end
