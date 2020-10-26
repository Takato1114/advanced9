class RoomsController < ApplicationController

  def create
    @room = Room.create
    @current_user_room = UserRoom.create(user_id: current_user.id, room_id: @room.id)
    @another_user_room = UserRoom.create(user_id: params[:user_id], room_id: @room.id)
    redirect_to chat_path(@room.id, user_id: params[:user_id])
  end

  
end