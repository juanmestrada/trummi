class AddIsdisabledToProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :isdisabled, :boolean, default: false
  end
end