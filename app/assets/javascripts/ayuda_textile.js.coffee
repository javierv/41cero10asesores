jQuery.fn.ayudaTextile = ->
  this.each ->
    $('<a href="/ayuda-textile">Ayuda del editor</a>')
      .click(->
        window.open(this.href, "",
          "resizable=yes, location=no, width=500, height=640, menubar=no, " +
          "status=no, scrollbars=yes")
        return false
      )
      .insertBefore(this)
      .wrap('<div class="ayuda-textile" />')

$(document).ready ->
  $('textarea:not(.no-avanzado)').ayudaTextile()
