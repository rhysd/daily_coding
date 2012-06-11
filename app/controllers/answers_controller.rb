# -*- coding: utf-8 -*-

class AnswersController < ApplicationController

  def index
    @answers = Answer.find_by_problem_id(params[:problem_id], params[:lang])
    html_str = render_to_string partial: 'index'
    render text: html_str
  end

  def profile
    @user = User.find_by_id(params[:uid])
    @my_answers = Answer.find_by_user_id(params[:uid]) || []
    @my_answers = @my_answers.class == Array ? @my_answers : [@my_answers]
  end

  def profile_fav
    stared_answer_ids = Fav.find_by_from(params[:uid]) || []
    stared_answer_ids = stared_answer_ids.class == Array ? stared_answer_ids : [stared_answer_ids]
    begin
      @stared_answers = Answer.find(stared_answer_ids)
    rescue ActiveRecord::RecordNotFound
      @stared_answers = []
    end
    authors = User.find(@stared_answers.map{|a| a.user_id})
    @stared_answers = @stared_answers.map.with_index do |a, i|
      tmp = {}
      tmp[:answer] = a
      tmp[:author] = authors[i]
      tmp
    end
  end

  def create
    Answer.create_or_update(current_user.id, params[:problem_id], params[:gisturl])
    render nothing: true
  end

  def destroy
    Answer.destroy(params[:answer_id])
  end

  private
  def setup(uid)
    user = User.find_by_twitter_id uid
    @my_answers = Answer.find_by_user_id(user.id) || []
    @my_answers = @my_answers.class == Array ? @my_answers : [@my_answers]
    stared_answer_ids = Fav.find_by_from(uid) || []
    stared_answer_ids = stared_answer_ids.class == Array ? stared_answer_ids : [stared_answer_ids]
    begin
      @stared_answers = Answer.find(stared_answer_ids)
    rescue ActiveRecord::RecordNotFound
      @stared_answers = []
    end
  end

end
