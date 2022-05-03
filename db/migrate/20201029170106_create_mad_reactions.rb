class CreateMadReactions < ActiveRecord::Migration[6.0]
  def change
    create_table :mad_reactions do |t|
    	t.boolean :mad_reaction
	    t.integer :user_id
	    t.integer :post_id
	    t.timestamps
    end
  end
end
