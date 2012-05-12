# -*- coding: utf-8 -*-

require 'lang_type'

class Answer < ActiveRecord::Base
  extend DailyCoding
  attr_accessible :lang, :url, :user_id

  def self.create_or_update(uid, gist_url)
    unless answer = Answer.find_by_url(gist_url)
      answer = Answer.new do |a|
        a.user = uid
        a.url = gist_url
        a.lang = lang_type(gist_url)
        a.save
      end
    end
    answer
  end
end
