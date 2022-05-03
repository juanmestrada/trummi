class CreateLaughingReactions < ActiveRecord::Migration[6.0]
  def change
    create_table :laughing_reactions do |t|
    	t.boolean :laughing_reaction
	    t.integer :user_id
	    t.integer :post_id
	    t.timestamps
    end
  end
end
