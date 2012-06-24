# -*- coding: utf-8 -*-

class ProblemsController < ApplicationController
  def index
    @problems = Problem.find_all_by_proposed(proposed: true)
  end

  def show
    @problem = Problem.find(params[:id])
  end

  def show_with_answers
    @problem = Problem.find(params[:id])
    begin
      @answers = @problem.answers
      @langs = @answers.collect {|a| a.lang}.uniq
    rescue => e
      @langs = []
    end
  end

  def today
    @today_problem = Problem.today
  end
end
