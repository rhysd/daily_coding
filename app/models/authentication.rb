class Authentication < ActiveRecord::Base
  attr_accessible :access_secret, :access_token, :bio, :image_url, :name, :provider, :screen_name, :uid, :user_id, :web_url
end
