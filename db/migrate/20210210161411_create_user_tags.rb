class CreateUserTags < ActiveRecord::Migration[6.0]
  def change
    create_table :user_tags do |t|
    	t.integer :profile_id
    	t.integer :tag_id
    end
  end
end
