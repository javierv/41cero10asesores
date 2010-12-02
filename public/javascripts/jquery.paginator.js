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
    image: '/images/loading.gif'
  };

  jQuery.extend( defaults, options );

  return this.each( function()
  {
    var $element = jQuery(this);
    defaults['success'] = function(data) { $element.html(data); }

    jQuery(defaults.paginator + ' a,' + defaults.table + ' th a', $element).live('click', function()
    {
      defaults['url'] = jQuery(this).attr("href");
      $element.empty().html('<p class="cargando"><img src="' + defaults.image +
                '" alt="">Cargando...</p>');
      $.ajax(defaults);
      return false;
    });
  });
}
