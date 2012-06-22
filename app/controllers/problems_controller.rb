# -*- coding: utf-8 -*-

class ProblemsController < ApplicationController
  def index
    @problems = Problem.find_all_by_proposed(proposed: true)
  end

  def show
    @problem = Problem.find(params[:id])
    @answers = @problem.answers #Answer.find_by_problem_id(@today_problem.id)
    @langs = @answers.collect {|a| a.lang}.uniq
  end

  def today
    @today_problem = Problem.today
    @answers = @today_problem.answers #Answer.find_by_problem_id(@today_problem.id)
    @langs = @answers.collect {|a| a.lang}.uniq
  end
end
