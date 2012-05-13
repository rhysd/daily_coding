# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#

$(document).ready ->
  $("form#gist-url-form").ajaxForm ->
    console.log('form commit sucess!')
    $.get '/answers', (data) ->
      alert('投稿しました。')
      $('div#answers-body div#one-program').remove()
      $('div#answers-body').append(data)
      $("ul#lang-selector li").removeClass('active')
      $('a#all-lang').parent().addClass('active') # 強制的にALL表示

  $("a#answers-show").click ->
    console.log('button success!')
    $.get '/answers', (data) ->
      $('div#answers-body div#one-program').remove()
      $('div#answers-body').append(data)
      $('a#all-lang').parent().addClass('active')
      # $('div.gist-part').each ->
      #   url = $(this).attr('data-src')
      #   $.getJSON url, (res) ->
      #     $('div#answers-body').append(res.div)
      # $(this).hide()

  $("ul#lang-selector a.lang-btn").click ->
    url = $(this).attr('data-href')
    lang_button = $(this)
    $.get url, (data) ->
      # lang_button.parent().removeClass('active')
      $("ul#lang-selector li").removeClass('active')
      console.log(lang_button.parent())
      lang_button.parent().addClass('active')
      $('div#answers-body div#one-program').remove()
      $('div#answers-body').append(data)

  # fav create
  $("div#answers-body").delegate "a.fav-btn", 'click', (evt) ->
    console.log('fav!!!')
    fav_btn = $(this)
    $.post '/fav/create/' + $(this).attr('data-answer-id'), (data) ->
      fav_btn.find('img').attr('src','/assets/star_full.png')

