$(document).ready ->
  imagen_quitable = (imagen) ->
    src = imagen.attr("src")
    contenedor = $('<div class="quitar_imagen"></div>')
    imagen.wrap(contenedor).before(
      $('<a href="' + src + '" title="Quitar imagen" class="quitar_imagen">Quitar</a>').click ->
        textarea = $("textarea")
        textarea.val(textarea.val().replace("!" + src + "!", "")).keydown()
        false
    )

  window.imagenes_quitables = -> $("#preview img").each -> imagen_quitable($(this))
