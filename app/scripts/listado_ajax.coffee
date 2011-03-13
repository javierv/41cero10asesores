$(document).ready ->
  $("#listado").ajaxPaginator()
  $("#resultados_busqueda").ajaxPaginator hide_while_loading: true
