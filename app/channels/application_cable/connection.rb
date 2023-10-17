module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # channelでcurrent_userが使えるようにする
    identified_by :current_user

    def connect
      # ユーザーを認証し、current_userに設定する
      self.current_user = find_verified_user
    end

    protected
    def find_verified_user
      # 現在の接続が検証されたユーザーを見つける
      verified_user = User.find_by(id: env['warden'].user.id)
      return reject_unauthorized_connection unless verified_user
      verified_user
    end

    def session
      # セッション情報を取得
      cookies.encrypted[Rails.application.config.session_options[:key]]
    end
  end
end
