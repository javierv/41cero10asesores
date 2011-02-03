$("a.destroy").live('ajax:success', (xhr, data, status) ->
  $('tbody tr', data).appendTo('#listado tbody')
  # TODO: tengo que pasar a esto el botón de deshacer.
  # Lo de borrar la fila lo puedo hacer basándome en el enlace.
)
