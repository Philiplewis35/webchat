class MessagesController < ApplicationController

  def create
    Message.create!(message_params)
    ActionCable.server.broadcast("room_channel_#{message_params[:channel_id]}", message: message_params[:text])
    head :ok
  end

  private

  def message_params
    params.require(:message).permit!
  end
end
