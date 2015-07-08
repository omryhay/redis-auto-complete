class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.int :user_id
      t.int :rating_count
      t.timestamps null: false
    end
  end
end
