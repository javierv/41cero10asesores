$(document).ready ->
  $('#fotos a').attr('title', 'Inserta esta imagen en la página').live('click', ->
    $('textarea').append('!' + this.href + '!').animate({scrollTop: 10000}, 300)
    false
  )