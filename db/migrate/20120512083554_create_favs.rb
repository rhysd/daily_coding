class CreateFavs < ActiveRecord::Migration
  def change
    create_table :favs do |t|
      t.integer :problem, :null => false
      t.integer :answer_id, :null => false
      t.integer :from, :null => false

      t.timestamps
    end
  end
end
