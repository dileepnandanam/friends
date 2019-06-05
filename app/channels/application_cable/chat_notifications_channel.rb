module ApplicationCable
  class ChatNotificationsChannel < ApplicationCable::Channel
    def subscribed
      stream_for current_user
    end

    def appear(data)
      current_user.update_attributes(online: true)
    end

    def away
      current_user.update_attributes(online: false)
    end
  end
end