class Closet < ApplicationRecord

  belongs_to :user

  has_many_attached :images

  # タグのリレーションシップ
  has_many :closet_tags, dependent: :destroy
  has_many :tags, through: :closet_tags

  enum season: { spring:0, summer:1, autumn:2, winter:3, other:4 }

end
