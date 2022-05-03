class CreateWhatReactions < ActiveRecord::Migration[6.0]
  def change
    create_table :what_reactions do |t|
    	t.boolean :what_reaction
	    t.integer :user_id
	    t.integer :post_id
	    t.timestamps
    end
  end
end
