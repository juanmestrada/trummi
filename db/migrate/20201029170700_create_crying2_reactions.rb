class CreateCrying2Reactions < ActiveRecord::Migration[6.0]
  def change
    create_table :crying2_reactions do |t|
    	t.boolean :crying2_reaction
	    t.integer :user_id
	    t.integer :post_id
	    t.timestamps
    end
  end
end
