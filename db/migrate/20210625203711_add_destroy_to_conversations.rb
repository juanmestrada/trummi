class AddDestroyToConversations < ActiveRecord::Migration[6.0]
  def change
    add_column :conversations, :author_destroy, :boolean, default: false
    add_column :conversations, :receiver_destroy, :boolean, default: false
  end
end
