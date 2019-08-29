$(document).on('turbolinks:load', function() {
	App.appearance = App.cable.subscriptions.create("ApplicationCable::ChatNotificationsChannel", {
		received(data) {
			$('.chat-thread').append(data['chat'])
			$('.chat-thread').scrollTop($('.chat-thread').prop('scrollHeight'))
			$.ajax({
				url: data['ack_url'],
				method: 'PUT'
			})
		}
	})
})