class ProfileController < ApplicationController
  def codes
    setup
  end

  def stared_codes
    setup
  end

  private

  def setup
    @uid = params[:user_id]
    @user = User.find_by_twitter_id params[:user_id]
    @my_answers = Answer.find_by_user(params[:user_id]) || []
    stared_answer_ids = Fav.find_by_from(params[:user_id]) || []
    begin
      @stared_answers = Answer.find stared_answer_ids
    rescue ActiveRecord::RecordNotFound
      @stared_answers = []
    end
  end

end
