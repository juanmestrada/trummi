class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
    	t.text :content

     	t.timestamps
    end
    add_foreign_key :posts, :users
  end
end
