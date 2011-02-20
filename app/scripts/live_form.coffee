$(document).ready ->
  $('#main').prepend('<div id="preview"></div>')

  $('input[name=preview]').remove()

  $('input[type=text], textarea', $('form.pagina')).typeWatch(
    callback: ->
      $('form.pagina').ajaxSubmit(
        success: (data) ->
          $('head').append($('#css', data).html())
          $('#preview').html($('#preview', data).html())
          $('#sidebar').remove()
          $('#sidebar', data).prependTo('#extra')
        data: { preview: true }
      )
    wait: 1000
    captureLenght: 1
  )
