class RemoveUserFromPersonalMessages < ActiveRecord::Migration[6.0]
  def change
    remove_column :personal_messages, :user_id
  end
end
