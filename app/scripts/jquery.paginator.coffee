# encoding: utf-8

###
 ajaxPaginator es un plugin que permite hacer paginación vía Ajax.
 Copyright Javi <elretirao@elretirao.net>
 Ver http://docs.jquery.com/License para la licencia.
 
 Opciones:
 paginador: string con el elemento que tiene los enlaces de paginación. Por defecto, '#paginador'.
 table:	string con el elemento que tiene los datos. Por defecto, 'table'.
 image: la imagen a mostrar mientras se ejecuta la operación.
###

jQuery.fn.ajaxPaginator = (options) ->
  defaults =
    paginator: '#paginador'
    table: 'table'
    beforeSend: -> $('#flashMessage').remove()
    cargando: 'Cargando...'
    history: true

  jQuery.extend(defaults, options)

  this.each ->
    $element = jQuery(this)
    defaults['success'] = (data) -> $element.html(data)

    if defaults.history
      if history && history.pushState
        $(window).bind("popstate", -> load_page($element, location.href, defaults))
      else
        $.history.init (hash) -> if hash != '' then load_page($element, hash, defaults)

    jQuery(defaults.paginator + ' a,' + defaults.table + ' th a', $element).live('click', ->
      if defaults.history
        if history && history.pushState
          history.pushState(null, document.title, @href)
          load_page($element, @href, defaults)
        else
          $.history.load(@href)
      else
        load_page($element, @href, defaults)
      
      return false
    )

load_page = (element, url, options) ->
  options['url'] = url
  element.empty().html('<p class="cargando">' + options.cargando + '</p>')
  $.ajax(options)
