cambiar_ocultos = (cambio) ->
  if cambio == 'mostrar'
    'ocultar'
  else
    'mostrar'

$('document').ready ->
  $('input:radio').change ->
    if this.checked
      cambiado = $(this)
      if this.name == 'ref_id'
        cambio = 'mostrar'
      else
        cambio = 'ocultar'

      $('input:radio').each ->
        if this == cambiado[0]
          cambio = cambiar_ocultos(cambio)
        else if this.name != cambiado.attr('name')
          if cambio == 'mostrar'
            $(this).show()
          else
            $(this).hide()
  $('input:radio[name="ref_id"]:gt(0):first').attr('checked', 'checked').change()
  $('input:radio[name="version_id"]:first').attr('checked', 'checked').change()