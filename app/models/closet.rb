class Closet < ApplicationRecord

  belongs_to :user

  has_many_attached :images
  validates :images, presence: true

  # タグのリレーションシップ
  has_many :closet_tags, dependent: :destroy
  has_many :tags, through: :closet_tags

  enum season: { spring:0, summer:1, autumn:2, winter:3, other:4 }

  def save_tag(sent_tags)
    current_tags=self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags=current_tags - sent_tags
    new_tags=sent_tags - current_tags

    old_tags.each do |old|
      self.closet_tags.delete ClosetTag.find_by(tag_id: old.id)
    end

    new_tags.each do |new|
      new_closet_tag=Tag.find_or_create_by(tag_name: new)
      self.tags << new_closet_tag
    end
  end

end
