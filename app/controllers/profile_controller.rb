class ProfileController < ApplicationController
  def index
    @screen_name = params[:user].login
    @icon_url = params[:user].profile_image_url
    @profile_description = params[:user].description
  end

  def codes
    @my_answers = Answer.find_by_user params[:user].twitter_id
  end

  def stared_codes
    stared_answer_ids = Fav.find_by_from(params[:user]).map{|t| t.answer_id}
    begin
      @stared_answers = Answer.find stared_answer_ids
    rescue => ActiveRecord::RecordNotFound
      return @stared_answers = []
    end
  end
end
