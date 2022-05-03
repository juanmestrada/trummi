class CreateUnsureReactions < ActiveRecord::Migration[6.0]
  def change
    create_table :unsure_reactions do |t|
    	t.boolean :unsure_reaction
	    t.integer :user_id
	    t.integer :post_id
	    t.timestamps
    end
  end
end
