class ChangePostColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :posts, :user_id, :profile_id
  end
end
