class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  after_create_commit :create_notifications
  
  private
  
  def create_notifications
    Notification.create(subject: self, user: post.user, action_type: :commented_to_own_post, checked: false)
  end 
end