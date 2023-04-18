class ClosetComment < ApplicationRecord

  belongs_to :user
  belongs_to :closet

  validates :comment, presence: true

end
