class RemoveForeignKeyPersonalMessages < ActiveRecord::Migration[6.0]
  def change
    change_table :personal_messages do |t|
      t.remove_foreign_key :users
    end
  end
end
