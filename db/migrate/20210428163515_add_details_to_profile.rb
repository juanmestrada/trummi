class AddDetailsToProfile < ActiveRecord::Migration[6.0]
  def change
  	change_table :profiles do |t|
	  t.remove :age, :weight
	  t.date :dob
	  t.string :location
	  t.string :religion
	  t.string :education
	end
  end
end
