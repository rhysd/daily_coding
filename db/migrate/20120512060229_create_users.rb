class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      ## Rememberable
      t.datetime :remember_created_at
      t.string :remember_token

      t.timestamps
    end

    add_index :users, :remember_token,  :unique => true
  end
end
