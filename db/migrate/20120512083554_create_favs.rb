class CreateFavs < ActiveRecord::Migration
  def change
    create_table :favs do |t|
      t.references :answer, :null => false
      t.references :user, :null => false

      t.timestamps
    end
  end
end
