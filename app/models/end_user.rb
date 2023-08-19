class EndUser < ApplicationRecord
  has_many :notifications, dependent: :destroy
  
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |end_user|
      end_user.password = SecureRandom.urlssfe_base64
      user.name = "guestuser"
      # user.confirmed_at = Time.now  Confirmable を使用している場合は必要
      # 例えば name を入力必須としているのならば, user.name = "ゲスト" なども必要
    end
  end
end
