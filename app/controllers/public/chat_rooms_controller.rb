class Public::ChatRoomsController < ApplicationController
  before_action :authenticate_user!
  def show
    @partner = User.find(params[:id])
    
    @chats_by_myself = Chat.where(user_id: current_user.id, partner_id: @partner.id)
    @chats_by_other = Chat.where(user_id: @partner.id,partner_id: current_user.id)
    
    @chats = @chats_by_myself.or(@chats_by_other)
    @chats = @chats.order(:created_at)
  end 

  def create
  end

  def index
    def index
    @my_chats = current_user.chats
    @chat_partners = User.where.not(id:current_user.id)
  end 
  end
end
