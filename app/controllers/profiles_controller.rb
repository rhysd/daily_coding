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
    @my_answers = @user.answers || []
    @my_answers = @my_answers.class == Array ? @my_answers : [@my_answers]
    stared_answer_ids = Fav.find_all_by_user_id(params[:user_id], :order => "created_at DESC")
    begin
      @stared_answers = Answer.find stared_answer_ids
    rescue ActiveRecord::RecordNotFound
      @stared_answers = []
    end
  end

end
