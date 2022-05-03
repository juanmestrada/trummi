class CreateFightmeReactions < ActiveRecord::Migration[6.0]
  def change
    create_table :fightme_reactions do |t|
    	t.boolean :fightme_reaction
	    t.integer :user_id
	    t.integer :post_id
	    t.timestamps
    end
  end
end
