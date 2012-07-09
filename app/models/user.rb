# -*- coding: utf-8 -*-

class User < ActiveRecord::Base
  include Devise::Models::Rememberable


  devise :omniauthable, :rememberable
  attr_accessible :remember_created_at, :remember_token, :provider, :uid, :nickname, :name, :email, :image, :blog_url, :github_url, :bio, :followers, :following, :oauth_token

  before_create :rememberable_value

  has_many :answers, :include => :favs, :dependent => :destroy
  has_many :favs, :dependent => :destroy

  def self.find_for_github_oauth(auth, signed_in_resource=nil)
    p auth.info
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(
        provider: auth.provider,
        uid: auth.uid,
        nickname: auth.info.nickname,
        name: auth.info.name,
        email: auth.info.email,
        image: auth.info.image,
        blog_url: auth.info.urls['Blog'],
        github_url: auth.info.urls['GitHub'],
        bio: auth.extra.raw_info['bio'],
        followers: auth.extra.raw_info['followers'],
        following: auth.extra.raw_info['following'],
        oauth_token: auth.credentials.token
      )
    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
        user.nickname = data["nickname"] if user.nickname.blank?
        user.name = data["name"] if user.name.blank?
        user.email = data["email"] if user.email.blank?
        # TODO
      end
    end
  end

  def rememberable_value
    self.remember_token ||= Devise.friendly_token
  end

end
