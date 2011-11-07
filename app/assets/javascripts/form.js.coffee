$(document).ready ->
  $('textarea').markItUp markitup_settings
  $('#error_messages a').click -> $($(this).attr('href')).focus()
