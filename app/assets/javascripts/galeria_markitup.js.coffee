jQuery.fn.galeriaMarkitup = ->
  this.each ->
    form = $('.foto form', $(this))
    form.live('submit', ->
      $(this).ajaxSubmit
        success: (responseText, statusText, xhr, $form) ->
          textarea = $('textarea')
          textarea.animate({scrollTop: 10000}, 300).
          val(textarea.val() + '!' + responseText.replace("\n", '') + '!').keydown()

      false
    )
    $('.buttons', form).hide()
    $(this).before('<p class="pista"><em>Pincha en cada imagen para insertarla en el contenido.</em></p>')

    $("img", $(this)).wrap('<a href="" title="Inserta la imagen en el contenido" />')
    $("a, img", $(this)).live "click", ->
      $("form", $(this).parents(".foto:first")).submit()
      false

$(document).ready -> $('#galeria').galeriaMarkitup()
