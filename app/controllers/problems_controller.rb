# -*- coding: utf-8 -*-

class ProblemsController < ApplicationController
  before_filter :authenticate_user!, :only => 'today'

  def index
    page = params[:page].presence || 1
    @problems = Problem.find_with_paging(page)
  end

  def show
    @problem = Problem.includes(:answers).find_by_id(params[:id])
    @problem.present? or raise InvalidResourceError, "該当する問題は存在しません。"
    @answers = @problem.present? ? @problem.answers : []
    if params[:lang]
      @answers = @answers.lang(params[:lang])
      @lang = params[:lang]
    end
    @langs = @answers.present? ? @answers.map {|a| a.lang}.uniq : []
  end

  def today
    @today_problem = Problem.today
    @today_problem.present? or raise InvalidResourceError, "今日の問題を取得できませんでした。時間を空けてアクセスしてください。"
  end
end
