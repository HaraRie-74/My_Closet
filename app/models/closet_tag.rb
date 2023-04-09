class ClosetTag < ApplicationRecord
  
  belongs_to :closet
  belongs_to :tag
  
  validates :closet_id, presence: true
  validates :tag_id, presence: true
  
end
