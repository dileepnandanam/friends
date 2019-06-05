class AddImageToChats < ActiveRecord::Migration[5.2]
  def up
    add_attachment :chats, :image
  end

  def down
    remove_attachment :chats, :image
  end
end
