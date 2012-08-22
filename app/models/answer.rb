# -*- coding: utf-8 -*-

class Answer < ActiveRecord::Base
  include DailyCoding::Exceptions
  attr_accessible :lang, :url, :raw_url, :user_id, :problem_id, :body, :raw_body

  MINUTE = 60           # 60s
  HOUR   = 60 * 60      # 3600s
  DAY    = 60 * 60 * 24 # 86400s

  has_many :favs, :dependent => :destroy
  belongs_to :problem
  belongs_to :user

  default_scope order('created_at DESC')
  scope :lang, lambda { |l| where(:lang => l) }
  scope :answers_by_pid, lambda { |p| includes(:favs).where(:problem_id => p) }
  scope :answers_by_uid, lambda { |u| includes(:favs).where(:user_id => u) }

  validates :lang,
    :presence => true,
    :length => { :in => 1..20},
    :format => { :with => /[\w]+/}
  validates :url,
    :presence => { :message => "は必ず入力して下さい。"},
    :uniqueness => { :message => "はすでに投稿されたURLです。"},
    :format => { :with => /http(s)?:\/\/gist\.github\.com\/[\d]+/, :message => "はGistのURLを入力して下さい。"} # Gist URL validattion
  validates :user_id,
    :presence => true,
    :numericality => { :only_integer => true, :greater_than => 0 }
  validates :problem_id,
    :presence => true,
    :numericality => { :only_integer => true, :greater_than => 0 }
  validates :body,
    :presence => true


  def self.find_by_problem_id(problem_id, lang_type=nil)
    answers =
      if lang_type.present?
        Answer.where(problem_id: problem_id, lang: lang_type).order('created_at DESC')
      else
        Answer.where(problem_id: problem_id).order('created_at DESC')
      end
  end

  def self.find_or_create_by_user_id_and_problem_id(user_id, problem_id, lang, gist_info)
    Answer.find_by_url(gist_info[:url]).present? and raise InvalidResourceError, "入力されたURLはすでに投稿されています。"
    Answer.create(
      user_id: user_id,
      problem_id: problem_id,
      lang: lang,
      url: gist_info[:url],
      raw_url: gist_info[:raw_url],
      body: gist_info[:html_content],
      raw_body: gist_info[:raw_content],
    )
  end

  def to_ago
    relative_sec = Time.now - self.created_at
    case relative_sec
    when 0 ... MINUTE then    sprintf "%d秒", relative_sec
    when MINUTE ... HOUR then sprintf "%d分", relative_sec / MINUTE
    when HOUR ... DAY then    sprintf "%d時間", relative_sec / HOUR
    else                      sprintf "%d日", relative_sec / DAY
    end
  end

end
