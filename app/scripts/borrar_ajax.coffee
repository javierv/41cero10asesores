$("a.destroy")
  .live('ajax:loading', ->
    $('#flash').remove()
    $('<div id="flash"></div>')
      .html('<p class="cargando">Cargando...</p>')
      .prependTo('#content')
  )
  .live('ajax:success', (xhr, data, status) ->
    $(this).parents('tr:first').fadeOut(->
      $(this).remove()
      $('tbody tr', data).hide().appendTo('#listado tbody').fadeIn()
    )
    $('#flash').html($('.flash', data))
  )
