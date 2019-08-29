module ApplicationCable
  class ConnectionNotificationsChannel < ApplicationCable::Channel
    def subscribed
      stream_for current_user
    end
  end
end