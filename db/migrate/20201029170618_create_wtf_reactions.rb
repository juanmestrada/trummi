class CreateWtfReactions < ActiveRecord::Migration[6.0]
  def change
    create_table :wtf_reactions do |t|
    	t.boolean :wtf_reaction
	    t.integer :user_id
	    t.integer :post_id
	    t.timestamps
    end
  end
end
