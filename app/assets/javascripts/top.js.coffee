# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#

$(document).ready ->
  $("form#gist-url-form").ajaxForm ->
    console.log('form commit sucess!')
    $.get '/answers', (data) ->
      $('answers-unit').append data

  $("a#answers-show").click ->
    console.log('button success!')
    $.get '/answers', (data) ->
      $('answers-unit').append data
      $(this).hide()

  $("ul#lang-selector a").click ->
    url = $(this).attr('data-href')
    console.log(url)
    $.get url, (data) ->
      $('div#answers-body').append data

