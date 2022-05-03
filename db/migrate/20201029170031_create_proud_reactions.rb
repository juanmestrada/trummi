class CreateProudReactions < ActiveRecord::Migration[6.0]
  def change
    create_table :proud_reactions do |t|
    	t.boolean :proud_reaction
	    t.integer :user_id
	    t.integer :post_id
	    t.timestamps
    end
  end
end
