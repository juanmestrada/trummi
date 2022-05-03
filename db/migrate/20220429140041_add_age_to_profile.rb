class AddAgeToProfile < ActiveRecord::Migration[6.0]
  def change
    remove_column :profiles, :isunderage
    remove_column :profiles, :dob

    add_column :profiles, :age, :integer
  end
end
