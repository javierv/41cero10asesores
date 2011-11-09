jQuery.fn.liveForm = ->
  this.each ->
    form = $(this)

    $('#main').prepend('<div id="preview"></div>')
    $('input[name=preview]').remove()

    send_form = (form) ->
      form.ajaxSubmit(
        beforeSend: ->
          $('#preview').addCargando()
        success: (data) ->
          $('head').append($('#css', data).html())
          $('#preview').html($('#preview', data).html()).removeCargando()
          $('#sidebar').remove()
          $('#sidebar', data).prependTo('#extra')
          sources = data.match(/script src="([^"]+)"/g)
          if sources
            for source in sources
              script = document.createElement('script')
              script.setAttribute "type","text/javascript"
              script.setAttribute "src", source.replace("script src=", "").replace(/"/g, "")
              document.getElementsByTagName("head")[0].appendChild(script)

          $('#preview').imagenesQuitables()
        data: { preview: true }
      )

    $('input[type=text], textarea', form).typeWatch(
      callback:       -> send_form(form)
      wait:           1000
      highlight:      false
      captureLenght:  1
    )

    send_form(form)


$(document).ready -> $('form.pagina').liveForm()