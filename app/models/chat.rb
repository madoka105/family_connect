class Chat < ApplicationRecord
   belongs_to :user
   
   validates :sentence, presence: true, length: { maximum: 140 }
end
