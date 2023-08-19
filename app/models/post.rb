class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :week_favorites, -> { where(created_at: 1.week.ago.beginning_of_day) }
  has_one :notification, as: :subject, dependent: :destroy



  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 検索
  def self.looks(word)
      @posts = Post.where("title LIKE? or text LIKE?","%#{word}%","%#{word}%")
  end
end
