$("a.destroy")
  .live('ajax:before', -> $('.flash').remove())
  .live('ajax:success', (xhr, data, status) ->
    $(this).parents('tr:first').remove()
    $('tbody tr', data).appendTo('#listado tbody')
    $(data).filter('.flash').prependTo('#content')
  )
