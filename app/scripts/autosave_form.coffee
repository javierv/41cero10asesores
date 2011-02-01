# encoding: utf-8

$(document).ready ->
  setInterval(
    ->
      $('form.pagina').ajaxSubmit(
        target: '#actualizado',
        data: {draft: true},
        success: -> $('#actualizado time').effect "highlight", {}, 3000
      )
    , 120000
  )
