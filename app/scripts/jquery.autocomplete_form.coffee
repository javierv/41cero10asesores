jQuery.fn.autocompleteForm = (options) ->
  defaults = inputs: "input[type='text']", url: '/autocomplete'

  jQuery.extend defaults, options

  this.each( ->
    $inputs = jQuery(defaults.inputs, jQuery(this))
    url = jQuery(this).attr('action')

    $inputs.each( ->
      $input = jQuery(this)
      nombre = $input.attr('name')
      $input.autocomplete(source: defaults.url + "?url=" + url + "&name=" + nombre)
    )
  )
