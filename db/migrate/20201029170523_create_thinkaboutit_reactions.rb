class CreateThinkaboutitReactions < ActiveRecord::Migration[6.0]
  def change
    create_table :thinkaboutit_reactions do |t|
    	t.boolean :thinkaboutit_reaction
	    t.integer :user_id
	    t.integer :post_id
	    t.timestamps
    end
  end
end
