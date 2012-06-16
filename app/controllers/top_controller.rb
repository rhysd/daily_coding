# -*- coding: utf-8 -*-

class TopController < ApplicationController
  def index
    @today_problem = Problem.today
    if logged_in?
      @answers = Answer.find_by_problem_id(@today_problem.id)
      @langs = @answers.collect {|a| a.lang}.uniq
    end
  end
end
