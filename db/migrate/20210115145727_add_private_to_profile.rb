class AddPrivateToProfile < ActiveRecord::Migration[6.0]
  def change
  	add_column :profiles, :private, :boolean, default: false
  end
end
