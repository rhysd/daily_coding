class AddIndexToAnswersUrlAndUserAndProblem < ActiveRecord::Migration
  change_table :answers do |t|
    t.index :url, :unique => true
    t.index :user_id
    t.index :problem_id
  end
end
