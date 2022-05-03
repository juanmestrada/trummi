class AddIsunderageToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :isunderage, :boolean, default: true
  end
end
