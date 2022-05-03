class AddIsunderageToProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :isunderage, :boolean, default: false
  end
end