# -*- coding: utf-8 -*-

class AnswersController < ApplicationController
  def index
    @answers = Answer.where(created_at: Date.yesterday..Date.today) # created_at指定して
  end

  def create
    Answer.create_or_update(current_user.id, params[:gisturl])
    render :nothing => true
  end

  def destroy
    Answer.destroy(params[:answer_id])
  end
end
