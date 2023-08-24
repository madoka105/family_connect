class Public::ChatsController < ApplicationController
  before_action :reject_non_related, only: [:show]


  def index
    @my_chats = current_user.chats
    # @chat_partnersは、相互フォロー状態のユーザーを入れるための変数
    # @chat_partners = User.where.not(id:current_user.id)

   @chat_partners = User.joins(:followers)
                     .where(followers: { followed_id: current_user.id })
                     .where(id: current_user.followers.pluck(:followed_id))

#    @chat_partners = current_user.
  end

  def show
    @partner = User.find(params[:id])

    @chats_by_myself = Chat.where(user_id: current_user.id, partner_id: @partner.id)
    @chats_by_other = Chat.where(user_id: @partner.id,partner_id: current_user.id)

    @chats = @chats_by_myself.or(@chats_by_other)
    @chats = @chats.order(:created_at)
  end

  def create
  end

  def destroy
  end


  def reject_non_related
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to users_path
    end
  end
end
