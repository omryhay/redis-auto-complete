class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.integer :user_id
      t.integer :rating_count
      t.timestamps null: false
    end
  end
end
