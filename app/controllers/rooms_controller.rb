class RoomsController < ApplicationController

  def create
    @room = Room.create
    @current_user_room = UserRoom.create(user_id: current_user.id, room_id: @room.id)
    @another_user_room = UserRoom.create(user_id: params[:user_id], room_id: @room.id)
    redirect_to room_path(@room.id, user_id: params[:user_id])
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
end