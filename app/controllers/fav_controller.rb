# -*- coding: utf-8 -*-

class FavController < ApplicationController
  def create
      if logged_in?
          Fav.new :problem => Problem.today, :answer_id => params[:answer_id], :from => current_user.id
      else
          render :status => 403
      end
  end

  def destroy
      if logged_in?
          begin
              Fav.delete :problem => Problem.today, :to => params[:answer_id], :from => current_user.id
          rescue
              render :status => 400
          end
      end
  end
end
