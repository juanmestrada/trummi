class AddProfileToUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
    t.belongs_to :user, foreign_key: true
    t.string :name
    t.string :headline
    t.text :about
    t.text :searchingfor
    t.integer :age
    t.string :ethnicity
    t.string :relationship
    t.string :sexuality
    t.string :height
    t.string :weight
    t.string :bodytype
    t.string :eyecolor
    t.string :haircolor
    t.string :living
    t.string :kids
    t.string :smoking
    t.string :drinking
    t.string :language

    t.timestamps
    end
  end
end
