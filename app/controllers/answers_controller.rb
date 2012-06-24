# -*- coding: utf-8 -*-

class AnswersController < ApplicationController

  def index
    @problem = Problem.find(params[:problem_id])
    begin
      @answers = @problem.answers.reverse
      @langs = @answers.map {|a| a.lang}.uniq
    rescue => e
      @langs = []
    end
  end

  def answers
    @answers = Answer.answers_by_pid(params[:problem_id]).recent
    render partial: 'answer', collection: @answers, :layout => false
  end

  def answers_by_lang
    @answers = Answer.answers_by_pid(params[:problem_id]).lang(params[:lang]).recent
    render partial: 'answer', collection: @answers, :layout => false
  end

  def profile
    @user = User.find(params[:uid])
    @my_answers = Answer.answers_by_uid(params[:uid]).recent || []
    @my_answers = @my_answers.class == Array ? @my_answers : [@my_answers]
  end

  def profile_fav
    faved_answer_ids = Fav.find_all_by_user_id(params[:uid]) || []
    faved_answer_ids = faved_answer_ids.class == Array ? faved_answer_ids : [faved_answer_ids]
    begin
      @faved_answers = Answer.find(faved_answer_ids)
    rescue ActiveRecord::RecordNotFound
      @faved_answers = []
    end
  end

  def create
    id = logged_in? ? current_user.id : 0
    Answer.create_or_update(id, params[:problem_id], params[:gisturl])
    redirect_to :action => 'index', :problem_id => params[:problem_id]
  end

  def destroy
    Answer.destroy(params[:answer_id])
    render nothing: true
  end

end
