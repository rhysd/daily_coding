class ProfilesController < ApplicationController
  before_filter :authenticate_user!

  def codes
    setup
  end

  def stared_codes
    setup
  end

  private

  def setup
    @uid = params[:user_id]
    @user = User.includes(:answers).includes(:favs).find_by_id(params[:user_id])
    @my_answers = @user.present? ? @user.answers : []
    stared_answer_ids = @user.present? ? @user.favs.map! {|f| f.id } : []
    begin
      @stared_answers = Answer.find_all_by_id(stared_answer_ids)
    rescue ActiveRecord::RecordNotFound
      @stared_answers = []
    end
  end

end
