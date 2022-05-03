class CreateThatsracistReactions < ActiveRecord::Migration[6.0]
  def change
    create_table :thatsracist_reactions do |t|
    	t.boolean :thatsracist_reaction
	    t.integer :user_id
	    t.integer :post_id
	    t.timestamps
    end
  end
end
