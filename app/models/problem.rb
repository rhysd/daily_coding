# -*- coding: utf-8 -*-

class Problem < ActiveRecord::Base
  attr_accessible :content, :url, :proposed_at
  has_many :answers, :include => :favs, :order => 'created_at DESC'

  validates :content,
    :presence => true
  # validates :url,
  #   :format => { :with => /http(s)?:\/\/([\w\-]+\.)+[\w\-]+(\/[\w\- .\/?%&=]*)?$/ } # Gist URL validattion
  validates :proposed_at,
    :presence => true


  def self.today
    Problem.includes(:answers).where(proposed: false).order("id ASC").first
  end

  def self.find_with_paging(page)
    Problem.where(proposed: true).order("id DESC").paginate(:page => page, :per_page => 30)
  end
end
