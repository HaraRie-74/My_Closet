class Closet < ApplicationRecord

  belongs_to :user

  has_many_attached :images
  validates :images, presence: true

  # タグのリレーションシップ
  has_many :closet_tags, dependent: :destroy
  has_many :tags, through: :closet_tags

  # コメントのリレーション
  has_many :closet_comments, dependent: :destroy

  # いいねのリレーションシップ
  has_many :favorites, dependent: :destroy
  
  # 画像認識タグのリレーションシップ
  has_many :vision_tags, dependent: :destroy

  enum season: { spring:0, summer:1, autumn:2, winter:3, other:4 }


  # タグに関しての定義
  def save_tag(sent_tags)
    # createアクションにて保存したcloset(self)に紐付いているタグが存在する場合、
    # 「タグの名前を配列として」全て取得する。
    current_tags=self.tags.pluck(:tag_name) unless self.tags.nil?
    # 既にclosetに存在するタグから、
    # 送信されてきたタグを以外をold_tagsに代入。
    old_tags=current_tags - sent_tags
    # 送信されてきたタグから、
    # 既にclosetに存在するタグ以外をnew_tagsに代入。
    new_tags=sent_tags - current_tags
    # 古いタグを削除
    old_tags.each do |old|
      old_tag=self.tags.where(tag_name: old)
      self.closet_tags.where(tag_id: old_tag).first.delete
    end
    # 新しいタグを保存。配列へ追加。
    new_tags.each do |new|
      new_closet_tag=Tag.find_or_create_by(tag_name: new)
      self.tags << new_closet_tag
    end
  end

  # いいねしているか判断する定義
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 公開・非公開
  scope :publish, -> {where(is_published_flag: true)}
  scope :unpublish, -> {where(is_published_flag: false)}

end
