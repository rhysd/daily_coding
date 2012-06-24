# -*- coding: utf-8 -*-

require 'open-uri'

class Answer < ActiveRecord::Base
  attr_accessible :lang, :url, :user_id, :problem_id, :body
  has_many :favs
  belongs_to :problem
  belongs_to :user
  scope :recent, order('created_at DESC')
  scope :lang, lambda { |l| where(:lang => l) }
  scope :answers_by_pid, lambda { |p| where(:problem_id => p) }
  scope :answers_by_uid, lambda { |u| where(:user_id => u) }

  def self.find_by_problem_id(problem_id, lang_type=nil)
    answers =
      if lang_type
        Answer.where(problem_id: problem_id, lang: lang_type).order('created_at DESC')
      else
        Answer.where(problem_id: problem_id).order('created_at DESC')
      end
  end

  def self.create_or_update(uid, problem_id, gist_url)
    unless answer = Answer.find_by_url(gist_url)
      answer = Answer.new do |a|
        a.user_id = uid
        a.url = gist_url
        a.lang = DailyCoding::lang_type(gist_url)
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
