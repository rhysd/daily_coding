$ ->
  $("ul#lang-selector a.lang-btn").click ->
    url = $(this).attr('data-href')
    console.log(url)
    lang_btn = $(this)
    $.get url, (data) ->
      $("ul#lang-selector li").removeClass('active')
      lang_btn.parent().addClass('active')
      console.log(data)
      $('div#answers-body').html(data)
