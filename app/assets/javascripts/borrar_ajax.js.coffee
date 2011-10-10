$("a.destroy")
  .live('ajax:beforeSend', ->
    $('#flash').remove()
    $('<div id="flash" />').prependTo('#content')
    $("#listado").addCargando()
  )
  .live('ajax:success', (xhr, data, status) ->
    $("#listado").removeCargando()
    $(this).parents('tr:first').fadeOut(->
      $(this).remove()
      $('tbody tr', data).hide().appendTo('#listado tbody').fadeIn()
    )
    $('#flash').html($('.flash', data))
  )
