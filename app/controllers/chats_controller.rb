class ChatsController < ApplicationController
  def create
    if UserRoom.where(user_id: current_user.id, room_id: params[:chat][:room_id]).present?
      @chat = Chat.create(params.require(:chat).permit(:user_id, :body, :room_id).merge(user_id: current_user.id))
      @room = Room.find(params[:chat][:room_id])
      # redirect_to room_path(@chat.room_id, user_id: params[:chat][:to_user_id])
    else
      flash[:alert] = "メッセージ送信に失敗しました。"
    end
  end
  
  def show
    @user = User.find(params[:user_id])
    @room = Room.find(params[:id])
    if UserRoom.where(:user_id => current_user.id, :room_id => @room.id).present?
      @chats = @room.chats
      @chat = Chat.new
      @user_rooms = @room.user_rooms
    else
      redirect_back(fallback_location: root_path)
    end
  end

    private
    def chat_params
      params.require(:chat).permit(:room_id, :body)
    end
end
