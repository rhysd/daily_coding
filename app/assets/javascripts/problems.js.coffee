getRemainedTime = ->
  now = new Date()
  target = new Date(now.getFullYear(), now.getMonth(), now.getDate() + 1, 0, 0, 0) # tomorrow 00::00::00
  remained = target.getTime() - $.now() - 1000*60*5  # last 5 minutes is hard coding to adapt
  hours = Math.floor(remained / (1000*60*60))
  mins  = Math.floor(remained / (1000*60))
  secs  = Math.floor(remained / 1000)
  return hours + '::' + mins + '::' + secs

$ ->
  $('#counter').countdown {
    compact: true,
    until: getRemainedTime(),
    timerEnd: -> alert(5),
    format: 'hh:mm:ss'
  }

