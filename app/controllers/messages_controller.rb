class MessagesController < ApplicationController

  def create
    message = Message.create!(message_params)
    ActionCable.server.broadcast("room_channel_#{message.channel_id}", { html: render_to_string(partial: "show", locals: { message: message }) })
    # TODO: Error handling
  end

  private

  def message_params
    params.require(:message).permit!
  end
end
