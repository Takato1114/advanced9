class UsersController < ApplicationController
  before_action :login_check, only: [:index, :edit, :show]
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new

    @current_user_room = UserRoom.where(user_id: current_user.id)
    @another_user_room = UserRoom.where(user_id: @user.id)
    unless @user_id == current_user.id
      @current_user_room.each do |current|
        @another_user_room.each do |another|
          if current.room_id == another.room_id
            @is_room = true
            @room_id = current.room_id
          end
        end
      end
      unless @is_room
        @room = Room.new
        @user_room = UserRoom.new
      end
    end
  end


  def index
    @users = User.all
    @book = Book.new
  # endを追加
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def following
    @user = User.find(params[:id])
  end

  def follower
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def login_check
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
