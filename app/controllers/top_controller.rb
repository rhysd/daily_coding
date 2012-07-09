# -*- coding: utf-8 -*-

class TopController < ApplicationController
  def index
    @today_problem = Problem.today
    redirect_to problems_today_path if user_signed_in?
  end
end
