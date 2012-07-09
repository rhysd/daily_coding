# -*- coding: utf-8 -*-

class FavController < ApplicationController
  before_filter :login_check

  def create
    Fav.find_or_create(params[:answer_id], current_user.id)
    head :created, :nothing => true
  end

  def destroy
    begin
      Fav.find_or_delete(params[:answer_id], current_user.id)
    rescue
      head :noting => true, status: :not_found
    end
    head :ok, :nothing => true
  end

  private

  def login_check
    head :unauthorized, :nothing => true unless user_signed_in?
  end
end
