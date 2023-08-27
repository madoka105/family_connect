class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notifications

  validates :comment, presence: true, length: { minimum: 1, maximum: 400 }

  private

  def create_notifications
    Notification.create(subject: self, user: post.user, action_type: :commented_to_own_post, checked: false)
  end
end
