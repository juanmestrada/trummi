class CreateTellmemoreReactions < ActiveRecord::Migration[6.0]
  def change
    create_table :tellmemore_reactions do |t|
    	t.boolean :tellmemore_reaction
	    t.integer :user_id
	    t.integer :post_id
	    t.timestamps
    end
  end
end
