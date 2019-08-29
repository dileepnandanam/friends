$(document).on('turbolinks:load', function() {
	scroll_to_bottom = function() {
		$('.chat-thread').scrollTop($('.chat-thread').prop('scrollHeight'))
	}

	$('.chats').on('click', '.open-image-upload', function() {
		$(this).siblings('.image-upload').removeClass('d-none')
	})

	$('.chat-thread').scrollTop($('.chat-thread').prop('scrollHeight'))

	$('.connections').on('ajax:success', 'a', function(e) {
		$('.chats').html(e.detail[2].responseText)
		scroll_to_bottom()
		$('.chats').find('form').on('ajax:success',function(e) {
			$('.chat-thread').append(e.detail[2].responseText)
			$(this).find('textarea').val('')
			scroll_to_bottom()
			$('.image-upload').addClass('d-none')
		})
	})

	$('.chats').on('keypress', 'textarea', function(e) {
		if(e.which == 13) {
			Rails.fire($(this).closest('form')[0], 'submit')
			$('textarea').val('')
		}
	})
})