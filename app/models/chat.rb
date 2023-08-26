class Chat < ApplicationRecord
   belongs_to :user

   # バリデーション(空でない、かつ最大140文字までに設定)
   validates :sentence, presence: true, length: { maximum: 140 }
end
