###
 ajaxPaginator es un plugin que permite usar un paginador con AJAX.
 Copyright Javi <elretirao@elretirao.net>
 Ver http://docs.jquery.com/License para la licencia.
 
 Opciones:
 paginador: string con el elemento que tiene los enlaces para paginar. Por defecto, '#paginador'.
 table:	string con el elemento que tiene los datos. Por defecto, 'table'.
 loading: texto a mostrar mientras carga el resultado.
###

browser_supports_history = ->
  history && history.pushState

jQuery.fn.ajaxPaginator = (options) ->
  defaults =
    paginator: '.pagination'
    table: 'table'
    beforeSend: -> $('#flashMessage').remove()
    loading: 'Cargando...'
    hide_while_loading: false

  jQuery.extend(defaults, options)

  this.each ->
    $element = jQuery(this)
    defaults['success'] = (data) ->
      $element.html(data)
      $element.removeCargando()

    if !browser_supports_history()
      $.history.init (hash) -> if hash != '' then load_page($element, hash, defaults)

    jQuery(defaults.paginator + ' a,' + defaults.table + ' th a', $element).live('click', ->
      if browser_supports_history()
        history.pushState(null, document.title, @href)
        load_page($element, @href, defaults)
        $(window).bind("popstate", -> load_page($element, location.href, defaults))
      else
        $.history.load(@href)
      
      return false
    )

load_page = (element, url, options) ->
  options['url'] = url
  if options["hide_while_loading"]
    element.empty().html('<p class="loading">' + options.loading + '</p>')
  else
    element.addCargando()
  $.ajax(options)
