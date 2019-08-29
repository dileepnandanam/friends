$(document).on('turbolinks:load', function() {
  App.appearance = App.cable.subscriptions.create("ApplicationCable::ConnectionNotificationsChannel", {
    received(data) {
      $.ajax({
        url: '/users/connections',
        type: 'GET',
        success: function(data) {
          $('.chats').html(data)
        }
      })
    }
  })
})