class CreateExcitedReactions < ActiveRecord::Migration[6.0]
  def change
    create_table :excited_reactions do |t|
    	t.boolean :excited_reaction
	    t.integer :user_id
	    t.integer :post_id
	    t.timestamps
    end
  end
end
