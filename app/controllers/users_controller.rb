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
    @displayed_answers = @stared_answers
  end

  private

  def setup
    @user = User.includes(:answers).includes(:favs).find_by_id(params[:user_id])
    @user.present? or raise DailyCoding::Exceptions::InvalidResourceError, "該当するユーザは存在しません。"
    @my_answers = @user.answers
    stared_answer_ids = @user.present? ? @user.favs.map! {|f| f.id } : []
    @stared_answers = Answer.find_all_by_id(stared_answer_ids)
  end

end
