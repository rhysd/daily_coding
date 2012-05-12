class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :url, :null => false
      t.string :lang, :null => false
      t.text   :body, :null => false
      t.references :user

      t.timestamps
    end
  end
end
