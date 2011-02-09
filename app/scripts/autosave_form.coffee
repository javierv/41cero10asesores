$(document).ready ->
  $('form.pagina').autosaveForm(
    target: '#actualizado'
    data: {draft: true}
    success: ->
      $('#actualizado time').effect "highlight", {}, 3000
      $('input[name*="borrador_id"]').val(
        $('#actualizado .borrador').attr('id').match(/\d+$/)[0]
      )
  )
