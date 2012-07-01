# -*- coding: utf-8 -*-

class ProblemsController < ApplicationController
  def index
    page = params[:page].presence || 1
    @problems = Problem.find_with_paging(page)
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
