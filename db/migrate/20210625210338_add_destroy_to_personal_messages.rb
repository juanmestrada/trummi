class AddDestroyToPersonalMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :personal_messages, :author_destroy, :boolean, default: false
    add_column :personal_messages, :receiver_destroy, :boolean, default: false
  end
end
