class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider, :null => false
      t.string :uid, :null => false        # github id
      t.string :nickname, :null => false   # login
      t.string :email
      t.string :name
      t.string :image                      # avater_url
      t.string :blog_url                   # blog
      t.string :github_url, :null => false # home_url
      t.string :bio
      t.integer :followers
      t.integer :following
      t.string :oauth_token, :null => false

      t.timestamps
    end

    add_index :users, :uid,  :unique => true
    add_index :users, :nickname, :unique => true
    add_index :users, :email, :unique => true
  end
end
