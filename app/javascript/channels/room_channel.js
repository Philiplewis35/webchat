import consumer from "./consumer"

$(document).ready(function() {
  if($('.channel_container').length > 0) {
    setup_room()
  }
})

function setup_room() {
  consumer.subscriptions.create({ channel: "RoomChannel", channel_id: $('.channel_container').attr('data-channel-id')}, {
    connected() {
      console.log('connected to channel' + $('.channel_container').attr('data-channel-id'))
      // so and so joined
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // so and so left
      // destory user channel

      // Called when the subscription has been terminated by the server
    },

    received(data) {
      $('.chat-container').append(data["html"])
      // Called when there's incoming data on the websocket for this channel
    }
  });
}
