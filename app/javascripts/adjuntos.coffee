$(document).ready ->
  formulario = $('#nueva_imagen')
  if window.FileReader
    formulario.addClass('droppable')
  formulario.fileUploadUI(
    uploadTable: $('<table class="upload_files"></table>').insertAfter(formulario),
    buildUploadRow: (files, index) ->
      file = files[index]
      $(
        '<tr>' +
        '<td>' + file.name + '<\/td>' +
        '<td class="file_upload_progress"><div><\/div><\/td>' +
        '<td class="file_upload_cancel">' +
        '<div class="ui-state-default ui-corner-all ui-state-hover" title="Cancel">' +
        '<span class="ui-icon ui-icon-cancel">Cancel<\/span>' +
        '<\/div>' +
        '<\/td>' +
        '<\/tr>'
      )    
    onLoad: (event, files, index, xhr, handler) ->
      $('.upload_files').fadeOut('slow', -> $(this).empty().fadeIn())
      $('#galeria').append(this.parseResponse(xhr).imagen)
  )
  $('.actions', formulario).hide()
