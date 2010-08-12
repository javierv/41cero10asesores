module CssJsHelper
  def js_form
    markitup
    css 'form'
    javascript 'form'
  end

  def markitup
    css '/javascripts/markitup/skins/simple/style.css',
      '/javascripts/markitup/sets/textile/style.css'
    javascript 'markitup/jquery.markitup', 'markitup/sets/textile/set'
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
end