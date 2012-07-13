# -*- coding: utf-8 -*-

require 'open-uri'

class AnswersController < ApplicationController
  helper_method :gist_url?
  before_filter :authenticate_user!, :only => [:create, :destroy]

  def answers
    @answers = Answer.answers_by_pid(params[:problem_id]).recent
    render partial: 'answer', collection: @answers, :layout => false
  end

  def answers_by_lang
    @answers = Answer.answers_by_pid(params[:problem_id]).lang(params[:lang]).recent
    render partial: 'answer', collection: @answers, :layout => false
  end

  def profile
    @user = User.find(params[:uid])
    @my_answers = Answer.answers_by_uid(params[:uid]).recent || []
  end

  def profile_fav
    faved_answer_ids = Fav.find_all_by_user_id(params[:uid])
    begin
      @faved_answers = Answer.find(faved_answer_ids)
    rescue ActiveRecord::RecordNotFound
      @faved_answers = []
    end
  end

  def create
    id = user_signed_in? ? current_user.id : 0
    content = content_by_gist_url(params[:gisturl])
    unless content.present?
      raise DailyCoding::Exceptions::InvalidURLError, "入力されたURLが適切ではありません。GistのURLを投稿して下さい。"
    end
    Answer.find_or_create(id, params[:problem_id], params[:gisturl], content)
    redirect_to problem_path(params[:problem_id]), :notice => "投稿できました。"
    if params[:twitter_post]
        client.update "@"+current_user[:login]+" さんが今日の問題に解答しました。 "+problems_today_url+" via @daily_coding"
    end
  end

  def destroy
    Answer.destroy(params[:id])
    redirect_to :back
  end

  def gist_url?(url)
    uri = URI.parse(url)
    return false unless uri.host == "gist.github.com" && uri.path =~ /\d{1,8}/ # github.com/12345678
    true
  end

  private

  def content_by_gist_url(url)
    uri = URI.parse(url + '.json')
    begin
      content = uri.read
    rescue
      return nil
    end
    return nil if (content.status == "404" || content.status == "302") || gist_url?(url) == false
    hash_from_gist(content)
  end

  def hash_from_gist(content)
    json = JSON.parse content
    json['div']
  end

end
