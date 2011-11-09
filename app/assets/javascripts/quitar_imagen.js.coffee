jQuery.fn.imagenesQuitables = ->
  this.each ->
    $("img", $(this)).each ->
      src = $(this).attr("src")
      contenedor = $('<div class="quitar_imagen"></div>')
      $(this).wrap(contenedor).before(
        $('<a href="' + src + '" title="Quitar imagen" class="quitar_imagen">Quitar</a>').click ->
          textarea = $("textarea")
          textarea.val(textarea.val().replace("!" + src + "!", ""))
          $(this).parent().fadeOut()
          false
      )
