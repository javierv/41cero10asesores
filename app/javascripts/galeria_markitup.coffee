$(document).ready ->
  $('#fotos a').attr('title', 'Inserta esta imagen en la página').live('click', ->
    area = $('textarea')
    area.append('!' + this.href + '!').animate({scrollTop: 10000}, 300)
    false
  )