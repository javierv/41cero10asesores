$(document).ready ->
  setInterval(
    ->
      $('form.simple_form').ajaxSubmit(
        target: '#actualizado',
        data: {draft: true},
        success: -> $('#actualizado time').effect "highlight", {}, 3000
      )
    , 120000
  )