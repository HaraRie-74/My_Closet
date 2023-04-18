class ClosetComment < ApplicationRecord

  belongs_to :user
  belongs_to :closet

  validates :comment, length: { minimum: 1, maximum: 100 }

end
