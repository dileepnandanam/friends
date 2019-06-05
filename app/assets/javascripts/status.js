$(document).on('turbolinks:load', function() {
	$.ajax({url: '/set_status', data: {state: 'online'}})
	window.onbeforeunload = function() {
		$.ajax({url: '/set_status', data: {state: 'offline'}})
	}
})