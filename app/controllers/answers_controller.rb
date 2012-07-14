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

  def create
    content = content_by_gist_url(params[:gisturl])
    content.present? or raise InvalidURLError, "入力されたURLが適切ではありません。GistのURLを投稿して下さい。"
    Answer.find_or_create_by_gisturl(current_user.id, params[:problem_id], params[:gisturl], content)
    redirect_to problem_path(params[:problem_id]), :notice => "投稿できました。"
    if params[:twitter_post]
      twitter_client.update "@"+current_user.twitter.screen_name+" さんが今日の問題に解答しました。 "+problems_today_url+" via @daily_coding"
    end
  end

  def destroy
    Answer.destroy(params[:id])
    redirect_to :back
  end

  def gist_url?(url)
    uri = URI.parse(url)
    uri.host == "gist.github.com" && uri.path =~ /\d{1,8}/ # github.com/12345678
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
