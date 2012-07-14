# -*- coding: utf-8 -*-

class Fav < ActiveRecord::Base
  attr_accessible :answer_id, :user_id
  belongs_to :user
  belongs_to :answer

  default_scope order("created_at DESC")

  validates :answer_id,
    :presence => true
  validates :user_id,
    :presence => true


  def self.destroy_by_answer_id_and_user_id(answer_id, uid)
    fav = Fav.find_by_answer_id_and_user_id(answer_id, uid)
    fav.present? and Fav.delete(fav.id)
  end
end
