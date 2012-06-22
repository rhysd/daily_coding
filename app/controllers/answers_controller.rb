# -*- coding: utf-8 -*-

class AnswersController < ApplicationController

  def index
    @answers = Answer.find_by_problem_id(params[:problem_id], params[:lang])
    html_str = render_to_string partial: 'answer', collection: @answers
    render text: html_str
  end

  def profile
    @user = User.find_by_id(params[:uid])
    @my_answers = Answer.find_by_user_id(params[:uid]) || []
    @my_answers = @my_answers.class == Array ? @my_answers : [@my_answers]
  end

  def profile_fav
    faved_answer_ids = Fav.find_by_user_id(params[:uid]) || []
    faved_answer_ids = faved_answer_ids.class == Array ? faved_answer_ids : [faved_answer_ids]
    begin
      @faved_answers = Answer.find(faved_answer_ids)
    rescue ActiveRecord::RecordNotFound
      @faved_answers = []
    end
  end

  def create
    Answer.create_or_update(current_user.id, params[:problem_id], params[:gisturl])
    render nothing: true
  end

  def destroy
    Answer.destroy(params[:answer_id])
    render nothing: true
  end

  def edit
  end

  def update
  end

end
