class Problem < ActiveRecord::Base
  attr_accessible :content, :url

  def self.today()
    Problem.where(proposed: false).order("id ASC").first
  end
end
