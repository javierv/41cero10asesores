$(document).ready ->
  $('form.simple_form').fileUploadUI(
    uploadTable: $('<table class="upload_files"></table>').appendTo('#main'),    
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
      $('#galeria').append(this.parseResponse(xhr).imagen)
  )
  $('form.simple_form .actions').hide()
