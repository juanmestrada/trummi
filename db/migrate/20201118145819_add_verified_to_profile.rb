class AddVerifiedToProfile < ActiveRecord::Migration[6.0]
  def change
  	add_column :profiles, :verified, :boolean, default: false
  end
end
