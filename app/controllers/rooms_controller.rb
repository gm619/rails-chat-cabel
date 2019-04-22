class RoomsController < ApplicationController
  before_action :load_entities

  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new permited_parametrs

    if @room.save
      flash[:success] = "Room #{@room.name} was created successfully"
      redirect_to rooms_path
    else
      flash[:error] = "Room was not created"
      render :new
    end
  end

  def show
    @room_message = RoomMessage.new room: @room
    @room_messages = @room.room_messages.includes(:user)
  end

  def edit
  end

  def update
    if @room.update(permited_parametrs)
      flash[:notice] = "Room #{@room.name} was updated successfully"
      redirect_to rooms_path
    else
      flash[:error] = "Room was not updated"
      render :new
    end
  end

  protected

  def load_entities
    @rooms = Room.all
    @room = Room.find(params[:id]) if params[:id]
  end

  def permited_parametrs
    params.require(:room).permit(:name)
  end
end
