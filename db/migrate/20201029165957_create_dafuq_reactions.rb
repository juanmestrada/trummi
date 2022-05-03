class CreateDafuqReactions < ActiveRecord::Migration[6.0]
  def change
    create_table :dafuq_reactions do |t|
    	t.boolean :dafuq_reaction
	    t.integer :user_id
	    t.integer :post_id
	    t.timestamps
    end
  end
end
