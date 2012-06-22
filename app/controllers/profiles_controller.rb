class ProfilesController < ApplicationController
  def codes
    setup
  end

  def stared_codes
    setup
  end

  private

  def setup
    @uid = params[:user_id]
    @user = User.find_by_id(params[:user_id])
    @my_answers = Answer.find_all_by_user_id(@user.id) || []
    @my_answers = @my_answers.class == Array ? @my_answers : [@my_answers]
    stared_answer_ids = Fav.find_all_by_user_id(params[:user_id]) || []
    stared_answer_ids = stared_answer_ids.class == Array ? stared_answer_ids : [stared_answer_ids]
    begin
      @stared_answers = Answer.find stared_answer_ids
    rescue ActiveRecord::RecordNotFound
      @stared_answers = []
    end
  end

end
