# -*- coding: utf-8 -*-

require 'open-uri'

class AnswersController < ApplicationController
  include DailyCoding::GistUtil

  before_filter :authenticate_user!, :only => [:create, :destroy]

  def answers
    @answers = Answer.answers_by_pid(params[:problem_id])
    render partial: 'answer', collection: @answers, layout: false
  end

  def answers_by_lang
    @answers = Answer.answers_by_pid(params[:problem_id]).lang(params[:lang])
    render partial: 'answer', collection: @answers, layout: false
  end

  def show
    @answer = Answer.find_by_id(params[:id])
    @answer.present? or raise InvalidResourceError, "指定された投稿は存在しません。"
  end

  def create
    gist_info = create_gist(params[:content], params[:lang])
    gist_info[:html_content] = gist_content_by_url(gist_info[:url])
    gist_info[:html_content].present? or raise InvalidURLError, "入力されたURLが適切ではありません。GistのURLを投稿して下さい。"
    answer = Answer.find_or_create_by_user_id_and_problem_id(current_user.id, params[:problem_id], params[:lang], gist_info)
    post_to_twitter(answer.id) if params[:twitter_post]
    redirect_to problem_path(params[:problem_id]), :notice => "投稿できました。"
  end

  def destroy
    Answer.destroy(params[:id])
    redirect_to :back
  end

  private

  def post_to_twitter(answer_id)
    if params[:twitter_post]
      twitter_client.update "@"+current_user.twitter.screen_name+" さんが今日の問題に回答しました。 "+answer_url(answer_id)+" #daily_coding"
    end
  end

  def create_gist(content, lang)
    p convert2ext(lang)
    response = github_client.create_gist(
      description: "Posted by DailyCoding Application",
      public: false,
      files: { "euler#{Problem.today.id}.#{convert2ext(lang)}" => {content: content} },
    )
    {
      url: response.html_url,
      raw_url: response.files.first[1].raw_url,
      raw_content: response.files.first[1].content
    }
  end

  def post_to_twitter(answer_id)
    twitter_client.update "@"+current_user.twitter.screen_name+" さんが今日の問題に解答しました。 "+answer_url(answer_id)+" via @daily_coding"
  end

end
