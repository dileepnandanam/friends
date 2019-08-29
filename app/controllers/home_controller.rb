class HomeController < ApplicationController
  def show
  end

  def set_status
  	status = {
  		'offline' => false,
  		'online' => true
  	}
  	current_user.update_attributes(online: status[params[:state]])
    unless current_user.online
      current_user.update(engaged: false)
      current_user.user.update(engaged: false, user_id: nil)
      ApplicationCable::ConnectionNotificationsChannel.broadcast_to(
        current_user.user,
        message: 'please reconnect'
      )
      current_user.update(user_id: nil)
    end
  end
end