class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.text :content, :null => false
      t.string :url
      t.boolean :proposed, :null => false, :default => false
      t.date   :proposed_at, :null => false

      t.timestamps
    end
  end
end
