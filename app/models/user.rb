# -*- coding: utf-8 -*-

class User < ActiveRecord::Base
  include Devise::Models::Rememberable

  devise :omniauthable, :rememberable
  attr_accessible :remember_created_at, :remember_token, :provider, :uid, :nickname, :name, :email, :image, :blog_url, :github_url, :bio, :followers, :following, :oauth_token

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
        user.nickname = data["info"]["nickname"] if user.nickname.blank?
        user.name = data["info"]["name"] if user.name.blank?
        user.email = data["info"]["email"] if user.email.blank?
        user.image = data["info"]["image"] if user.image.blank?
        user.blog_url = data["info"]["urls"]["Blog"] if user.blog_url.blank?
        user.github_url = data["info"]["urls"]["GitHub"] if user.github_url.blank?
        user.bio = data["info"]["bio"] if user.bio.blank?
        user.followers = data["extra"]["raw_info"]["followers"] if user.followers.blank?
        user.following = data["extra"]["raw_info"]["following"] if user.following.blank?
        user.oauth_token = data["credentials"]["token"] if user.oauth_token.blank?
      end
    end
  end

  # It is necessary to put this method because of devise's bug I guess
  def rememberable_value
    User.remember_token
  end

end
