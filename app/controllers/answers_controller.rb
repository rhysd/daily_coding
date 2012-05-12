# -*- coding: utf-8 -*-

class AnswersController < ApplicationController

  def index
    # @answers = Answer.where(updated_at: Date.today..Date.tomorrow).order('updated_at DESC') # created_at指定して
    @answers = Answer.order('updated_at DESC') # created_at指定して
    @langs = @answers.collect {|a| a.lang}
    logger.debug(@langs)
    html_str = render_to_string partial: 'index'
    render text: html_str
  end

  def create
    Answer.create_or_update(current_user.id, params[:gisturl])
    render nothing: true
  end

  def destroy
    Answer.destroy(params[:answer_id])
  end

end
