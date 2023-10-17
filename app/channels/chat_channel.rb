class ChatChannel < ApplicationCable::Channel
  def subscribed
    # チャンネルに購読されたときの処理
    # "chat_channel" からのストリームを受信する
    stream_from "chat_channel"
    # 現在のユーザーのIDに基づいてストリームを受信する
    stream_for current_user.id
  end

  def unsubscribed
    # チャンネルが購読解除されたときの処理
    # 通常、クリーンアップ処理がここに含まれます
  end

  def speak(data)
    if data["sentence"]
      # チャットメッセージを作成してデータベースに保存
      Chat.create!(
        user_id: data["current_user_id"].to_i,
        partner_id: data["partner_id"].to_i,
        sentence: data["sentence"]
      )
      # 画面を開いているのがチャット送信者だった場合
      # チャットメッセージを送信者のチャンネルにブロードキャスト
      ChatChannel.broadcast_to data["current_user_id"].to_i,
        sentence: data["sentence"],
        partner_id: data["partner_id"],
        isCurrent_user: true

      # 画面を開いているのがチャット受信者だった場合
      # チャットメッセージを受信者のチャンネルにブロードキャスト
      ChatChannel.broadcast_to data["partner_id"].to_i,
        sentence: data["sentence"],
        partner_id: data["partner_id"],
        isCurrent_user: false,
        send_user: data["current_user_id"].to_i
    end
  end
end