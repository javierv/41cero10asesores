/**
 * ajaxPaginator es un plugin que permite hacer paginación vía Ajax.
 * Copyright Javi <elretirao@elretirao.net>
 * Ver http://docs.jquery.com/License para la licencia.
 *
 * Opciones:
 * paginador: string con el elemento que tiene los enlaces de paginación.
 *				Por defecto, '#paginador'.
 * table:	string con el elemento que tiene los datos. Por defecto, 'table'.
 * image: la imagen a mostrar mientras se ejecuta la operación.
 */

jQuery.fn.ajaxPaginator = function( options )
{
  var defaults =
  {
    paginator: '#paginador',
    table: 'table',
    beforeSend: function()
    {
      $('#flashMessage').remove();
    },
    cargando: 'Cargando...',
    history: true
  };

  jQuery.extend( defaults, options );

  return this.each( function()
  {
    var $element = jQuery(this);
    defaults['success'] = function(data) { $element.html(data); }

    if(defaults.history)
    {
      $.history.init(function(hash)
      {
        if(hash != '')
        {
          load_page($element, hash, defaults)
        }
      })
    }

    jQuery(defaults.paginator + ' a,' + defaults.table + ' th a', $element).live('click', function()
    {
      var url = jQuery(this).attr("href");
      if(defaults.history)
      {
        $.history.load(url);
      }
      else
      {
        load_page($element, url, defaults);
      }
      return false;
    });
  });
}

function load_page(element, url, options)
{
  options['url'] = url;
  element.empty().html('<p class="cargando">' + options.cargando + '</p>');
  $.ajax(options);
}