class ClosetComment < ApplicationRecord
  
  belongs_to :user
  belongs_to :closet
  
end
