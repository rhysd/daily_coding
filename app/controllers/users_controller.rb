# -*- coding: utf-8 -*-

class UsersController < ApplicationController
  before_filter :authenticate_user!
  layout 'user'

  def codes
    setup
    @displayed_answers = @my_answers
  end

  def stared_codes
    setup
    @stared_answers = Answer.find_all_by_id(@stared_answer_ids)
    @displayed_answers = @stared_answers
  end

  private

  def setup
    @user = User.includes(:answers).includes(:favs).find_by_id(params[:user_id])
    @user.present? or raise InvalidResourceError, "該当するユーザは存在しません。"
    @stared_answer_ids = @user.favs.map! {|f| f.answer_id }
    @my_answers = @user.answers
    @my_answers.present? and @stared_counts = Fav.counts_faved_to_me(@my_answers)
  end

end
