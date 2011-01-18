$(document).ready ->
  $('#fotos a').live('click', ->
    area = $('textarea')
    area.append('!' + this.href + '!').animate({scrollTop: 10000}, 300)
    false
  )