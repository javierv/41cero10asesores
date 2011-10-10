# encoding: utf-8

module CssJsHelper
  def listado
    tabla
  end

  def tabla
    paginador_ajax
    javascript "borrar_ajax"
  end

  def paginador_ajax
    javascript 'jquery.history', 'jquery.paginator', 'listado_ajax'
  end

  def live_preview_form
    javascript 'jquery.form'
    javascript 'typewatch'
    js_form
    javascript 'live_form'
  end

  def autosave_form
    javascript 'jquery.effects.core'
    javascript 'jquery.effects.highlight'
    javascript 'jquery.form'
    javascript 'jquery.autosave_form'
    javascript 'autosave_form'
  end

  def js_form
    markitup
    javascript 'form'
  end

  def markitup
    javascript 'markitup/jquery.markitup', 'markitup/sets/textile/set', 'ayuda_textile'
  end

  def bsmselect
    javascript 'jquery.ui.core', 'jquery.ui.widget', 'jquery.ui.mouse',
      'jquery.ui.draggable', 'jquery.ui.droppable', 'jquery.ui.sortable',
      'jquery.bsmselect'
  end

  def bsmselect_con_cajas
    bsmselect
    javascript 'cajas'
  end

  def autocomplete
    javascript 'jquery.ui.core', 'jquery.ui.widget', 'jquery.ui.position',
      'jquery.ui.autocomplete', 'jquery.autocomplete_form'
  end

  def adjuntos_ajax
    javascript 'jquery.ui.core', 'jquery.fileupload', 'jquery.fileupload-ui'
  end

  def google_maps
    javascript "http://maps.google.com/maps/api/js?sensor=false", "google_maps"
  end
end
