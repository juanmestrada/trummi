class AddImageToProfile < ActiveRecord::Migration[6.0]
  def change
  	add_column :profiles, :image1, :string 
  	add_column :profiles, :image2, :string
  	add_column :profiles, :image3, :string
  	add_column :profiles, :image4, :string     
  end
end
