class AddDeviseToUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      ## Rememberable
      t.datetime :remember_created_at
      t.string :remember_token
    end
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
