# -*- coding: utf-8 -*-

require 'open-uri'

class AnswersController < ApplicationController
  helper_method :gist_url?
  before_filter :authenticate_user!, :only => [:create, :destroy]

  # def index
  #   @answers = Answer.answers_by_pid(params[:problem_id])
  #   if params[:lang]
  #     @answers = @answers.lang(params[:lang])
  #   end
  #   render :template , collection: @answers, layout: false
  # end

  # def answers
  #   @answers = Answer.answers_by_pid(params[:problem_id])
  #   render partial: 'answer', collection: @answers, layout: false
  # end

  # def answers_by_lang
  #   @answers = Answer.answers_by_pid(params[:problem_id]).lang(params[:lang])
  #   render partial: 'answer', collection: @answers, layout: false
  # end

  def show
    @answer = Answer.find_by_id(params[:id])
    @answer.present? or raise InvalidResourceError, "指定された投稿は存在しません。"
  end

  def create
    content = content_by_gist_url(params[:gisturl])
    content.present? or raise InvalidURLError, "入力されたURLが適切ではありません。GistのURLを投稿して下さい。"
    answer = Answer.find_or_create_by_gisturl(current_user.id, params[:problem_id], params[:gisturl], content)
    redirect_to problem_path(params[:problem_id]), :notice => "投稿できました。"
    post_to_twitter(answer.id)
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

  def post_to_twitter(answer_id)
    if params[:twitter_post]
      twitter_client.update "@"+current_user.twitter.screen_name+" さんが今日の問題に回答しました。 "+answer_url(answer_id)+" #daily_coding"
    end
  end

  def content_by_gist_url(url)
    uri = open(url + '.json', :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE)
    begin
      content = uri.read
    rescue => e
      require 'pp'
      pp e
      return nil
    end
    Rails.logger.warn content.inspect # 本番環境でこれがないとなぜか動かない
    return nil if (uri.status == "404" || uri.status == "302") || gist_url?(url) == false
    hash_from_gist(content)
  end

  def hash_from_gist(content)
    json = JSON.parse content
    json['div']
  end

end
