$(document).ready ->
  form = $('#galeria .foto form')
  form.ajaxForm(
    success: (responseText, statusText, xhr, $form) ->
      textarea = $('textarea')
      textarea.animate({scrollTop: 10000}, 300).
      val(textarea.val() + '!' + responseText.replace("\n", '') + '!').keydown()
  )
  $('.actions', form).hide()
  $('#galeria img').attr('title', 'Inserta la imagen en la página').
  click -> $('form', $(this).parent()).submit()
