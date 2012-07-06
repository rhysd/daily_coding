# -*- coding: utf-8 -*-

require 'nokogiri'

class Answer < ActiveRecord::Base
  attr_accessible :lang, :url, :user_id, :problem_id, :body

  MINUTE = 60           # 60s
  HOUR   = 60 * 60      # 3600s
  DAY    = 60 * 60 * 24 # 86400s

  has_many :favs, :dependent => :destroy
  belongs_to :problem
  belongs_to :user

  scope :recent, order('created_at DESC')
  scope :lang, lambda { |l| where(:lang => l) }
  scope :answers_by_pid, lambda { |p| includes(:favs).where(:problem_id => p) }
  scope :answers_by_uid, lambda { |u| includes(:favs).where(:user_id => u) }

  validates :lang,
    :presence => true,
    :length => { :in => 1..20},
    :format => { :with => /[\w]+/}
  validates :url,
    :presence => { :message => "は必ず入力して下さい。"},
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

  def self.find_or_create(uid, problem_id, gist_url, content)
    answer = find_or_initialize_by_url(gist_url)
    if answer.present?
      answer.user_id = uid
      answer.url = gist_url
      answer.lang = self.lang_type(gist_url)
      answer.body = content
      answer.problem_id = problem_id
      answer.save
    end
    answer
  end

  def to_ago
    relative_sec = Time.now - self.created_at
    if 0 <= relative_sec && relative_sec < MINUTE
      sprintf "%d秒", relative_sec
    elsif MINUTE <= relative_sec && relative_sec < HOUR
      sprintf "%d分", relative_sec / MINUTE
    elsif HOUR <= relative_sec && relative_sec < DAY
      sprintf "%d時間", relative_sec / HOUR
    elsif DAY <= relative_sec
      sprintf "%d日", relative_sec / DAY
    else
      nil
    end
  end

  private

  def self.lang_type(gist_url)
    doc = Nokogiri::HTML open(gist_url)
    result = doc.xpath('//div[@class="file"]/div').each do |div|
      if div.get_attribute("class") =~ /^data type-(.*)$/
        type = $1
        case type
        when "c"
          ext = File.extname doc.xpath('//div[@class="file"]')[0].get_attribute("id")
          type = "cpp" if %w[ .cpp .cc .cxx ].include? ext
        when "viml"
          type = "vim"
        end
        return type
      end
    end
    "others"
  end

end
