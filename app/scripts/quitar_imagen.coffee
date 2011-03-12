$(document).ready ->
  $('#preview img').live 'click', ->
    src = $(this).attr("src")
    $textarea = $('textarea')
    $textarea.val($textarea.val().replace("!" + src + "!", "")).keydown()
