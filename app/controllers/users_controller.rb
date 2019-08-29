class UsersController < ApplicationController
  before_action :check_user
  def show
    counts = get_user_counts
    @message = "Male(#{counts['male'].to_i}), Female(#{counts['female'].to_i}), others(#{counts['others'].to_i})"
    @user = current_user.user
    @chats = get_chats(@user.id)
    render 'show', layout: false, status: 200
  end

  def connect
    current_user.chats.update_all(hide: true)
    previous_user = current_user.user
    current_user.user.try(:update, engaged: false, user_id: nil)
    current_user.update(engaged: false, user_id: nil)
    gender = params[:gender]
    @user = User.where('id != ?', current_user.id).where(engaged: false, gender: params[:gender], online: true).order(Arel.sql('random()')).first
    if @user.present?
      @user.update(user_id: current_user.id, engaged: true)
      current_user.update(user_id: @user.id)
      @chats = get_chats(@user.id)
    else
      counts = get_user_counts
      @message = "No #{params[:gender].singularize} Users Available. Male(#{counts['male'].to_i}), Female(#{counts['female'].to_i}), others(#{counts['others'].to_i})"
    end
    reconnect(previous_user, @user)
    render 'show', layout: false, status: 200
  end

  def connections
    counts = get_user_counts
    @message = "Male(#{counts['male'].to_i}), Female(#{counts['female'].to_i}), others(#{counts['others'].to_i})"
    if params[:user_id]
      @user = User.find(params[:user_id])
      @chats = get_chats(@user.id)
    elsif current_user.user.present?
      @user = current_user.user
      @chats = get_chats(@user.id)
    end
  end

  protected

  def reconnect(user1, user2)
    [user1, user2].each do |user|
      ApplicationCable::ConnectionNotificationsChannel.broadcast_to(
        user,
        message: 'please reconnect'
      )
    end
  end

  def get_user_counts
    User.where(engaged: false, online: true).where('id != ?', current_user.id).group(:gender).count
  end

  def get_chats(from_user_id)
    Chat.where("sender_id = ? or reciver_id = ? and sender_id = ? or reciver_id = ?", current_user.id, current_user.id, from_user_id, from_user_id).order('created_at ASC')
  end
end