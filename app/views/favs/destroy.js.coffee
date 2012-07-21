
# switch image
if $('a.fav-btn > img').attr('src') == '/assets/star_full.png'
  $('a.fav-btn > img').attr('src','/assets/star_empty.png')

$('a.fav-btn').attr('href', "/favs/create/<%= j(render 'answer_id') %>")
