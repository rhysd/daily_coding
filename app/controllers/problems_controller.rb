# -*- coding: utf-8 -*-

class ProblemsController < ApplicationController
  def index
    page = params[:page].presence || 1
    @problems = Problem.find_with_paging(page)
  end

  def show
    @problem = Problem.includes(:answers).find(params[:id])
    @answers = @problem.present? ? @problem.answers : []
    @langs = @answers.present? ? @answers.map {|a| a.lang}.uniq : []
  end

  def today
    @today_problem = Problem.today
  end
end
