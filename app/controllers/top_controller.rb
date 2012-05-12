# -*- coding: utf-8 -*-

class TopController < ApplicationController
  def index
    @today_problem = Problem.today
    if logged_in?
      @answers = Answer.order('updated_at DESC') # created_at指定して
      @langs = @answers.collect {|a| a.lang}.uniq
    end
  end
end
