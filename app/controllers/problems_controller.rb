# -*- coding: utf-8 -*-

class ProblemsController < ApplicationController
  before_filter :authenticate_user!, :only => 'today'

  def index
    page = params[:page].presence || 1
    @problems = Problem.find_with_paging(page)
  end

  def show
    @problem = Problem.includes(:answers).find(params[:id])
    raise NoProblemError, "問題idが不適切です。" unless @problem.present?
    @answers = @problem.present? ? @problem.answers : []
    @langs = @answers.present? ? @answers.map {|a| a.lang}.uniq : []
  end

  def today
    @today_problem = Problem.today
    unless @today_problem.present?
      raise NoProblemError, "今日の問題を取得できませんでした。時間を空けてアクセスしてください。"
    end
  end
end
