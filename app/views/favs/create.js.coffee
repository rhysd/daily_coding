
# switch image
if $('a.fav-btn > img').attr('src') == '/assets/star_empty.png'
  $('a.fav-btn > img').attr('src','/assets/star_full.png')

$('a.fav-btn').attr('href', "/favs/destroy/<%= j(render 'answer_id') %>")
