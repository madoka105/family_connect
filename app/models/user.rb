class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_images, dependent: :destroy

  # フォローをした、されたの関係
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # 一覧画面で使う
  has_many :following_users, through: :followers, source: :followed
  has_many :follower_users, through: :followeds, source: :follower

  #フォローしたときの処理
  def follow(user_id)
    followers.create(followed_id: user_id)
  end

  #フォローを外すときの処理
  def unfollow(user_id)
    followers.find_by(followed_id: user_id).destroy
  end

  #フォローしていればtrueを返す
  def following?(user)
    following_users.include?(user)
  end

GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  #def self.guest?
  #  self.email == GUEST_USER_EMAIL
  #end
  
  # 検索方法
  def self.looks(word)
    @users = User.where("name LIKE?","%#{word}%")
  end

  has_one_attached :profile_image

   # プロフィール画像の取得メソッド
  def get_profile_image(height,width)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
    end
    profile_image.variant(resize_to_limit: [height, width]).processed
  end

  # is_withdrawalがfalseならtrueを返すようにしている
  def active_for_authentication?
    super && (is_withdrawal == false)
  end
end
