# -*- coding: utf-8 -*-

class Problem < ActiveRecord::Base
  attr_accessible :content, :url, :proposed_at
  has_many :answers, :order => 'created_at DESC'

  def self.today
    Problem.where(proposed: false).order("id ASC").first
  end

  def self.find_with_paging(page)
    Problem.where(proposed: true).order("id DESC").paginate(:page => page, :per_page => 30)
  end
end
