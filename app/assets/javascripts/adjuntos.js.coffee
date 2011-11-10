# TODO: no me gusta que .upload_files y #galeria sean dependientes...

jQuery.fn.adjuntaImagen = ->
  this.each ->
    if window.FileReader
      $(this).addClass('droppable')
    $(this).fileUploadUI(
      uploadTable: $('<table class="upload_files"></table>').insertAfter(this),
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
        $('#galeria').append(xhr.responseText)
    )
    $('.buttons', $(this)).hide()

$(document).ready ->
  $('#nueva_imagen').adjuntaImagen()
