# -*- coding: utf-8 -*-

class FavsController < ApplicationController
  before_filter :authenticate_user!

  def create
    Fav.find_or_create_by_answer_id_and_user_id(params[:answer_id], current_user.id)
    head :created, :nothing => true
  end

  def destroy
    Fav.destroy_by_answer_id_and_user_id(params[:answer_id], current_user.id)
    head :ok, :nothing => true
  end

end
