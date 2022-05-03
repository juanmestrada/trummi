class CreateTeaReactions < ActiveRecord::Migration[6.0]
  def change
    create_table :tea_reactions do |t|
    	t.boolean :tea_reaction
	    t.integer :user_id
	    t.integer :post_id
	    t.timestamps
    end
  end
end
