# encoding: utf-8

$(document).ready ->
  $('<a href="/ayuda-textile">Ayuda del editor</a>')
    .click(->
      window.open(this.href, "",
        "resizable=yes, location=no, width=500, height=640, menubar=no, " +
        "status=no, scrollbars=yes")
      return false
    )
    .insertBefore('textarea:not(.no-avanzado)')
    .wrap('<div class="ayuda-textile" />')
