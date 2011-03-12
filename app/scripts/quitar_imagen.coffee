$(document).ready ->
  imagen_quitable = (imagen) ->
    src = imagen.attr("src")
    contenedor = $('<div class="quitar_imagen"></div>')
    imagen.wrap(contenedor).before(
      $('<a href="' + src + '" class="quitar_imagen">Quitar</a>').click ->
        textarea = $("textarea")
        textarea.val(textarea.val().replace("!" + src + "!", "")).keydown()
        false
    )

  imagenes_quitables = -> $("#preview img").each -> imagen_quitable($(this))
