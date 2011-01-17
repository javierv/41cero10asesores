$(document).ready -> $('form.simple_form').fileUploadUI(
  uploadTable: $('.upload_files'),
  downloadTable: $('.download_files'),
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
  buildDownloadRow: (file) ->  $('<tr><td>' + file.name + '<\/td><\/tr>')
)