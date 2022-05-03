class CreateDisapprovalReactions < ActiveRecord::Migration[6.0]
  def change
    create_table :disapproval_reactions do |t|
    	t.boolean :disapproval_reaction
	    t.integer :user_id
	    t.integer :post_id
	    t.timestamps
    end
  end
end
