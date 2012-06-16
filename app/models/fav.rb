# -*- coding: utf-8 -*-

class Fav < ActiveRecord::Base
  attr_accessible :answer_id, :user_id
  belongs_to :user
  belongs_to :answer

  def self.find_or_create(answer_id, uid)
    unless Fav.find_by_answer_id_and_user_id(answer_id, uid)
      Fav.create(answer_id: answer_id, user_id: uid)
    end
  end

  def self.find_or_delete(answer_id, uid)
    if fav = Fav.find_by_answer_id_and_user_id(answer_id, uid)
      Fav.delete(fav.id)
    end
  end
end
