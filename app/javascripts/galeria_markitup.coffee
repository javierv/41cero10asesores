$(document).ready ->
  $('#galeria .foto form').ajaxForm(
    success: (responseText, statusText, xhr, $form) ->
      textarea = $('textarea')
      textarea.animate({scrollTop: 10000}, 300).
      val(textarea.val() + '!' + responseText.replace("\n", '') + '!').keydown()
  )