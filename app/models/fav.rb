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


  def self.destroy_by_answer_id_and_user_id(answer_id, user_id)
    fav = Fav.find_by_answer_id_and_user_id(answer_id, user_id)
    fav.present? and Fav.delete(fav.id)
  end

  def self.counts_faved_to_me(my_answers)
    answer_ids = my_answers.map { |a| a.id }
    Fav.find_all_by_answer_id(answer_ids).length
  end
end
