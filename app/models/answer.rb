# -*- coding: utf-8 -*-

require 'lang_type'
require 'open-uri'
require 'json'

class Answer < ActiveRecord::Base
  extend DailyCoding
  attr_accessible :lang, :url, :user
  has_many :fav
  belongs_to :problem
  belongs_to :user

  def self.find_by_problem_id(problem_id, lang_type=nil)
    answers =
      if lang_type
        Answer.where(problem_id: problem_id, lang: lang_type).order('updated_at DESC')
      else
        Answer.where(problem_id: problem_id).order('updated_at DESC')
      end
  end

  def self.create_or_update(uid, problem_id, gist_url)
    unless answer = Answer.find_by_url(gist_url)
      answer = Answer.new do |a|
        a.user_id = uid
        a.url = gist_url
        a.lang = lang_type(gist_url)
        a.body = self.hash_from_gist(gist_url + ".json")
        a.problem_id = problem_id
        a.save
      end
    end
    answer
  end

  def self.hash_from_gist(gist_url)
    logger.debug(gist_url)
    open(gist_url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE) do |f|
      json = JSON.parse f.read
      json['div']
    end
  end
end
