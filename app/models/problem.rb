# -*- coding: utf-8 -*-

class Problem < ActiveRecord::Base
  attr_accessible :content, :url
  has_many :answers, :order => 'created_at DESC'

  def self.today()
    Problem.where(proposed: false).order("id ASC").first
  end
end
