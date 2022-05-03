class ChangePersonalMessageBelongsTo < ActiveRecord::Migration[6.0]
  def change
    change_table :personal_messages do |t|
      t.belongs_to :profile, foreign_key: true
    end

    add_column :personal_messages, :read, :boolean, default: false
  end
end
