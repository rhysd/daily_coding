# -*- coding: utf-8 -*-

class FavController < ApplicationController
  before_filter :login_check

  def create
    Fav.find_or_create(params[:answer_id], current_user.id)
  end

  def destroy
    begin
      Fav.find_or_delete( params[:answer_id], current_user.id)
    rescue
     render status: 400
    end
  end

  private

  def login_check
    render status: 403 unless logged_in?
  end
end
