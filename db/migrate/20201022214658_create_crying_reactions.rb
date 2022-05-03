class CreateCryingReactions < ActiveRecord::Migration[6.0]
  def change
    create_table :crying_reactions do |t|
    	t.boolean :crying_reaction
	    t.integer :user_id
	    t.integer :post_id
	    t.timestamps
    end
  end
end
