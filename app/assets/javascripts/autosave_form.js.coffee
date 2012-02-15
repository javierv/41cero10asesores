jQuery.fn.autosaveHighlightForm = ->
  return this.each ->
    form = $(this)
    form.autosaveForm(
      target: '#actualizado'
      url: $('input[formaction*="draft"]').attr("formaction")
      success: ->
        $('#actualizado time', form).effect "highlight", {}, 3000
        $('input[name*="borrador_id"]', form).val(
          $('#actualizado .borrador', form).attr('id').match(/\d+$/)[0]
        )
    )

$(document).ready ->
  $('form.pagina').autosaveHighlightForm()
