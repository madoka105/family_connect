class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :week_favorites, -> { where(created_at: 1.week.ago.beginning_of_day) }
  has_one :notification, as: :subject, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  validates :title, presence: true, length: { minimum: 1, maximum: 20}
  validates :text, presence: true, length: { minimum: 1, maximum: 50}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 検索
  def self.looks(word)
      @posts = Post.where("title LIKE? or text LIKE?","%#{word}%","%#{word}%")
  end
end
