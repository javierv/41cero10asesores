module CssJsHelper
  def listado
    filtrador
    tabla
  end

  def filtrador
    css 'filtrador'
  end

  def tabla
    javascript 'jquery.history', 'jquery.paginator', 'listado_ajax'
    css 'tabla'
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
    javascript 'autosave_form'
  end

  def js_form
    markitup
    css 'form'
    javascript 'form'
  end

  def markitup
    css 'markitup', '/javascripts/markitup/sets/textile/style.css'
    javascript 'markitup/jquery.markitup', 'markitup/sets/textile/set', 'ayuda_textile'
  end

  def bsmselect
    css 'jquery.bsmselect'
    javascript 'jquery.ui.core', 'jquery.ui.widget', 'jquery.ui.mouse',
      'jquery.ui.draggable', 'jquery.ui.droppable', 'jquery.ui.sortable',
      'jquery.bsmselect'
  end

  def bsmselect_con_cajas
    bsmselect
    javascript 'cajas'
  end

  def autocomplete
    css 'jquery.ui.core', 'jquery.ui.theme', 'jquery.ui.autocomplete'
    javascript 'jquery.ui.core', 'jquery.ui.widget', 'jquery.ui.position',
      'jquery.ui.autocomplete', 'jquery.autocomplete_form'
  end
end