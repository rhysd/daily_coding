# -*- coding: utf-8 -*-

class AnswersController < ApplicationController
  def index
    @answers = Answer.where(created_at: Date.yesterday..Date.today) # created_at指定して
  end

  def create
  end

  def destroy
  end
end
