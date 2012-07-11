class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.integer :user_id,      :null => false
      t.string :provider,      :null => false
      t.string :uid,           :null => false
      t.string :screen_name,   :null => false
      t.string :name
      t.string :access_token,  :null => false
      t.string :access_secret
      t.string :bio
      t.string :image_url
      t.string :web_url

      t.timestamps
    end

    add_index :authentications, :user_id
    add_index :authentications, :screen_name
  end
end
