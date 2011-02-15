$(document).ready ->
  form = $('#galeria .foto form')
  form.live('submit', ->
    $(this).ajaxSubmit
      success: (responseText, statusText, xhr, $form) ->
        textarea = $('textarea')
        textarea.animate({scrollTop: 10000}, 300).
        val(textarea.val() + '!' + responseText.replace("\n", '') + '!').keydown()

    false
  )
  $('.actions', form).hide()
  $('#galeria img').attr('title', 'Inserta la imagen en el contenido').live(
    'click', -> $('form', $(this).parent()).submit()
  )
