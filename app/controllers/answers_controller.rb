# -*- coding: utf-8 -*-

class AnswersController < ApplicationController
  def index
    @answers = Answer.find_all() # created_at指定して
  end

  def create
  end

  def destroy
  end
end
