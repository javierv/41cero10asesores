jQuery.fn.liveForm = ->
  this.each ->
    form = $(this)

    $('#main').prepend('<div id="preview"></div>')
    preview_button = $('input[formaction*="preview"]')
    preview_button.remove()

    send_form = (form) ->
      form.ajaxSubmit(
        url: preview_button.attr("formaction")
        beforeSend: ->
          $('#preview').addCargando()
        success: (data) ->
          $('#preview').html($('#preview', data).html())
            .removeCargando().imagenesQuitables().worldMaps()
          $('#sidebar').remove()
          $('#sidebar', data).prependTo('#extra')
      )

    $('input[type=text], textarea', form).typeWatch(
      callback:       -> send_form(form)
      wait:           1000
      highlight:      false
      captureLenght:  1
    )

    send_form(form)


$(document).ready -> $('form.pagina').liveForm()
