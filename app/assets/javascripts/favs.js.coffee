$ ->
  # fav create
  $("a.fav-btn").click ->
    fav_btn = $(this)
    # fav create
    if fav_btn.find('img').attr('src') == '/assets/star_empty.png'
      $.post '/favs/' + fav_btn.attr('data-answer-id'), (res) ->
        fav_btn.find('img').attr('src','/assets/star_full.png')
    else # fav delete
      $.ajax {
        'url': '/favs/' + fav_btn.attr('data-answer-id'),
        'type': 'DELETE',
        'success': (res) ->
          fav_btn.find('img').attr('src','/assets/star_empty.png')
      }

