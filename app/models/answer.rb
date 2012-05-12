# -*- coding: utf-8 -*-

require 'lang_type'
require 'open-uri'
require 'json'

class Answer < ActiveRecord::Base
  extend DailyCoding
  attr_accessible :lang, :url, :user

  def self.create_or_update(uid, gist_url)
    unless answer = Answer.find_by_url(gist_url)
      answer = Answer.new do |a|
        a.user_id = uid
        a.url = gist_url
        a.lang = lang_type(gist_url)
        a.body = self.hash_from_gist(gist_url + ".json")
        a.save
      end
    end
    answer
  end

  def self.hash_from_gist(gist_url)
    logger.debug(gist_url)
    open(gist_url) do |f|
      json = JSON.parse f.read
      json['div']
    end
  end
end
