jQuery.fn.borrarAjax = ->
  this.each ->
    listado = $(this)
    $("a.destroy", listado)
      .live('ajax:beforeSend', ->
        $('#flash').remove()
        $('<div id="flash" />').prependTo('#content')
        listado.addCargando()
      )
      .live('ajax:success', (xhr, data, status) ->
        listado.removeCargando()
        $(this).parents('tr:first').fadeOut(->
          $(this).remove()
          $('tbody tr', data).hide().appendTo($('tbody', listado)).fadeIn()
        )
        $('#flash').html($('.flash', data))
      )

$(document).ready ->
  $('#listado').borrarAjax()
