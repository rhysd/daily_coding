class AddIndexToProblemsProposed < ActiveRecord::Migration
  change_table :problems do |t|
    t.index :proposed
  end
end
