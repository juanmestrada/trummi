class AddPrivateTagsToProfile < ActiveRecord::Migration[6.0]
  def change
  	add_column :profiles, :private_tags, :boolean, default: false
  end
end
