###
 Autosave form is a wrapper for jQuery.form to send a form's data via AJAX regularly.

 Copyright Javi <elretirao@elretirao.net>
 This plugin is free software. See http://docs.jquery.com/License for conditions.
###
jQuery.fn.autosaveForm = (options) ->
  defaults =
    interval: 120000
  
  jQuery.extend(defaults, options)

  this.each ->
    setInterval(
      -> jQuery(this).ajaxSubmit(options),
      defaults.interval
    )
