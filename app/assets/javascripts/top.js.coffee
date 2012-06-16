# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#

$(document).ready ->

  $("form#gist-url-form").ajaxForm ->
    console.log('form commit sucess!')
    problem_id = $("div#today-problem").attr('data-problem-id')
    $.get '/answers/' + problem_id, (data) ->
      alert('投稿しました。')
      $('div#answers-body div#one-program').remove()
      $('div#answers-body').append(data)
      $("ul#lang-selector li").removeClass('active')
      $('a#all-lang').parent().addClass('active') # 強制的にALL表示

  $("a#answers-show").click ->
    console.log('button success!')
    problem_id = $("div#today-problem").attr('data-problem-id')
    $.get '/answers/' + problem_id, (data) ->
      $('div#answers-body div#one-program').remove()
      $('div#answers-body').append(data)
      $('a#all-lang').parent().addClass('active')

  $("ul#lang-selector a.lang-btn").click ->
    url = $(this).attr('data-href')
    lang_btn = $(this)
    $.get url, (data) ->
      $("ul#lang-selector li").removeClass('active')
      console.log(lang_btn.parent())
      lang_btn.parent().addClass('active')
      $('div#answers-body div#one-program').remove()
      $('div#answers-body').append(data)

  # fav create
  $("div#answers-body").delegate "a.fav-btn", 'click', (evt) ->
    fav_btn = $(this)
    # fav create
    if fav_btn.find('img').attr('src') == '/assets/star_empty.png'
      $.post '/fav/create/' + fav_btn.attr('data-answer-id'), (res) ->
          fav_btn.find('img').attr('src','/assets/star_full.png')
    else # fav delete
      $.ajax {
        'url': '/fav/destroy/' + fav_btn.attr('data-answer-id'),
        'type': 'DELETE',
        'success': (res) ->
          fav_btn.find('img').attr('src','/assets/star_empty.png')
      }

