class AddHideToChats < ActiveRecord::Migration[5.2]
  def change
    add_column :chats, :hide, :boolean, default: false
  end
end
