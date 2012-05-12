class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.text :content
      t.string :url
      t.boolean :proposed, :null => false, :default => false

      t.timestamps
    end
  end
end
