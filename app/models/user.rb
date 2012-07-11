# -*- coding: utf-8 -*-

class User < ActiveRecord::Base
  include Devise::Models::Rememberable

  devise :omniauthable, :rememberable
  attr_accessible :remember_created_at, :remember_token
  has_many :authentications
  has_many :answers, :include => :favs, :dependent => :destroy
  has_many :favs, :dependent => :destroy

  def twitter
    self.authentications.select {|a| a.provider == 'twitter'}.first
  end

  def github
    self.authentications.select {|a| a.provider == 'github'}.first
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    authentication = Authentication.find_by_provider_and_uid(auth.provider, auth.uid)
    if authentication
      authentication.user
    else
      user = User.new
      data = auth['extra']['raw_info']
      user.authentications.build(
        provider: auth['provider'],
        uid: auth['uid'],
        access_token: auth['credentials']['token'],
        access_secret: auth['credentials']['secret'],
        screen_name: data['screen_name'],
        name: data['name'],
        bio: data['description'],
        image_url: data['profile_image_url'],
        web_url: data['url'],
      )
      user.save!
      user
    end
  end

  def self.find_for_github_oauth(auth, signed_in_resource=nil)
    authentication = Authentication.find_by_provider_and_uid(auth.provider, auth.uid)
    if authentication
      authentication.user
    else
      user = User.new
      user.authentications.build(
        provider: auth.provider,
        uid: auth.uid,
        access_token: auth.credentials.token,
        screen_name: auth.info.nickname,
        name: auth.info.name,
        bio: auth.extra.raw_info['bio'],
        image_url: auth.info.image,
        web_url: auth.info.urls['Blog'],
      )
      user.save!
      user
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if session["devise.twitter_data"] && session["devise.twitter_data"]["extra"]["raw_info"]
        data = session["devise.twitter_data"]['extra']['raw_info']
        user.screen_name =  data['screen_name'] if user.screen_name.blank?
        user.name =  data['name'] if user.name.blank?
        user.bio =  data['description'] if user.bio.blank?
        image_url =  data['profile_image_url'] if user.image_url.blank?
        web_url =  data['url'] if user.web_url.blank?
        access_token =  data['credentials']['token'] if user.access_token.blank?
        access_secret =  data['credentials']['secret'] if user.access_secret.blank?
      end

      if session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
        data = session["devise.github_data"]["info"]
        user.screen_name = data["nickname"] if user.screen_name.blank?
        user.name = data["name"] if user.name.blank?
        user.image_url = data["image"] if user.image_url.blank?
        user.web_url = data["urls"]["Blog"] if user.web_url.blank?
        user.bio = data["bio"] if user.bio.blank?
        user.access_token = data["credentials"]["token"] if user.access_token.blank?
      end
    end
  end

  # It is necessary to put this method because of devise's bug I guess
  def rememberable_value
    User.remember_token
  end

end
