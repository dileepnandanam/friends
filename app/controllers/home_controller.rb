class HomeController < ApplicationController
  def show
  end

  def set_status
  	status = {
  		'offline' => false,
  		'online' => true
  	}
  	current_user.update_attributes(online: status[params[:state]])
  end
end