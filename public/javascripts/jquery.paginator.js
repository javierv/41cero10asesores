/* DO NOT MODIFY. This file was compiled Wed, 05 Jan 2011 00:39:47 GMT from
 * /home/javi/programas/work/calesur/app/javascripts/jquery.paginator.coffee
 */

(function() {
  /*
   ajaxPaginator es un plugin que permite hacer paginación vía Ajax.
   Copyright Javi <elretirao@elretirao.net>
   Ver http://docs.jquery.com/License para la licencia.

   Opciones:
   paginador: string con el elemento que tiene los enlaces de paginación. Por defecto, '#paginador'.
   table:	string con el elemento que tiene los datos. Por defecto, 'table'.
   image: la imagen a mostrar mientras se ejecuta la operación.
  */  var load_page;
  jQuery.fn.ajaxPaginator = function(options) {
    var defaults;
    defaults = {
      paginator: '#paginador',
      table: 'table',
      beforeSend: function() {
        return $('#flashMessage').remove();
      },
      cargando: 'Cargando...',
      history: true
    };
    jQuery.extend(defaults, options);
    return this.each(function() {
      var $element;
      $element = jQuery(this);
      defaults['success'] = function(data) {
        return $element.html(data);
      };
      if (defaults.history) {
        if (history && history.pushState) {
          $(window).bind("popstate", function() {
            return load_page($element, location.href, defaults);
          });
        } else {
          $.history.init(function(hash) {
            if (hash !== '') {
              return load_page($element, hash, defaults);
            }
          });
        }
      }
      return jQuery(defaults.paginator + ' a,' + defaults.table + ' th a', $element).live('click', function() {
        if (defaults.history) {
          if (history && history.pushState) {
            history.pushState(null, document.title, this.href);
            load_page($element, this.href, defaults);
          } else {
            $.history.load(this.href);
          }
        } else {
          load_page($element, this.href, defaults);
        }
        return false;
      });
    });
  };
  load_page = function(element, url, options) {
    options['url'] = url;
    element.empty().html('<p class="cargando">' + options.cargando + '</p>');
    return $.ajax(options);
  };
}).call(this);
