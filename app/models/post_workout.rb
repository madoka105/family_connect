class PostWorkout < ApplicationRecord
  has_one :notification, as: :subject, dependent: :destroy
end
