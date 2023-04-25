class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: {maximum:100}

  has_one_attached :profile_image

  has_many :closets, dependent: :destroy

  # コメントのリレーションシップ
  has_many :closet_comments, dependent: :destroy

  # いいねのリレーションシップ
  has_many :favorites, dependent: :destroy
  has_many :favorited_closets, through: :favorites, source: :closet

  # フォローのリレーションシップ
  has_many :active_relationships, class_name:"Relationship", foreign_key:"follow_id", dependent: :destroy
  has_many :following ,through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name:"Relationship", foreign_key:"followed_id", dependent: :destroy
  has_many :follows, through: :passive_relationships, source: :follow

  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path=Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io:File.open(file_path),filename:'default-image.jpg',content_type:'image/jpeg')
    end
    profile_image.variant(resize_to_limit:[width,height]).processed
  end

  # ユーザーをフォローする
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # ユーザーのフォローを外す
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # フォローしていればtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  # ゲストユーザー
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

end
