# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#

$(document).ready ->
  $("form#gist-url-form").ajaxForm ->
    console.log('form commit sucess!')
    $.get '/answers', (data) ->
      alert('投稿しました。')
      $('div#answers-body').append(data)

  $("a#answers-show").click ->
    console.log('button success!')
    $.get '/answers', (data) ->
      $('div#answers-body .gist-part').remove()
      $('div#answers-body').append(data)
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
      $('div#answers-body .gist-part').remove()
      $('div#answers-body').append(data)

  # fav create
  $("answers-body").delegate("a.fav-btn", 'click') ->
    $.post '/fav/create'
