$(document).ready ->
  $("#preview img").live "click", ->
    # TODO: la idea sería añadir un enlace alrededor o antes de la imagen,
    # y posicionarlo por CSS como una cruz en la esquina. O algo así.
    src = $(this).attr("src")
    $textarea = $("textarea")
    $textarea.val($textarea.val().replace("!" + src + "!", "")).keydown()
