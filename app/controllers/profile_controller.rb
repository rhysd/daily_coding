class ProfileController < ApplicationController
  def codes
    setup
    @answers = @my_answers
  end

  def stared_codes
    setup
    @answers = @stared_answers
  end

  private

  def setup
    @uid = params[:user_id]
    @user = User.find_by_twitter_id params[:user_id]
    @my_answers = Answer.find_by_user_id(@user.id) || []
    @my_answers = @my_answers.class == Array ? @my_answers : [@my_answers]
    stared_answer_ids = Fav.find_by_from(params[:user_id]) || []
    stared_answer_ids = stared_answer_ids.class == Array ? stared_answer_ids : [stared_answer_ids]
    begin
      @stared_answers = Answer.find stared_answer_ids
    rescue ActiveRecord::RecordNotFound
      @stared_answers = []
    end
  end

end
