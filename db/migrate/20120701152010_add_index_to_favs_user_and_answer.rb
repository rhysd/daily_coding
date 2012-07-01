class AddIndexToFavsUserAndAnswer < ActiveRecord::Migration
  change_table :favs do |t|
    t.index :user_id
    t.index :answer_id
  end
end
