class FavController < ApplicationController
  def create
      if logged_in?
          Fav.find_or_create :problem => Problem.today, :to => params[:answer_id], :from => current_user.twitter_id
      else
          render :status => 403
      end
  end

  def destroy
      if logged_in?
          begin
              Fav.delete :problem => Problem.today, :to => params[:answer_id], :from => current_user.twitter_id
          rescue
              render :status => 400
          end
      end
  end
end
