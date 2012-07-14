class Authentication < ActiveRecord::Base
  attr_accessible :access_secret, :access_token, :bio, :image_url, :name, :provider, :screen_name, :uid, :user_id, :web_url
  belongs_to :user

  validates :user_id, :presence => true, :numericality => { :only_integer => true, :greater_than => 0 }
  validates :provider, :presence => true, :inclusion => { :in => ['twitter', 'github'] }
  validates :uid, :presence => true, :numericality => { :only_integer => true }
  validates :access_token, :presence => true
  validates :image_url, :presence => true
end
