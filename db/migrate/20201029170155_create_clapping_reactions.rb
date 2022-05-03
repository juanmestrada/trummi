class CreateClappingReactions < ActiveRecord::Migration[6.0]
  def change
    create_table :clapping_reactions do |t|
    	t.boolean :clapping_reaction
	    t.integer :user_id
	    t.integer :post_id
	    t.timestamps
    end
  end
end
