class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :url, :null => false
      t.string :lang, :null => false
      t.integer :user
      t.integer :fav_count, :null => false

      t.timestamps
    end
  end
end
