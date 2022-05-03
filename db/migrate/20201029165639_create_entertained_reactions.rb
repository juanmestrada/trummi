class CreateEntertainedReactions < ActiveRecord::Migration[6.0]
  def change
    create_table :entertained_reactions do |t|
    	t.boolean :entertained_reaction
	    t.integer :user_id
	    t.integer :post_id
	    t.timestamps
    end
  end
end
