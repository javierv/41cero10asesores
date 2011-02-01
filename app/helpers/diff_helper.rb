# encoding: utf-8
module DiffHelper
  def diferencias(pagina_actual, pagina_anterior)
    actual = render_pagina(pagina_actual)
    anterior = render_pagina(pagina_anterior)
    content_for(:sidebar) {differ actual[:sidebar], anterior[:sidebar]}
    differ actual[:content], anterior[:content]
  end

  def botones_seleccion_diferencias(version)
    boton_referencia(version) + boton_id(version)
  end

  def texto_version_modificada(version)
    html = "Modificada el #{content_tag :span, l(version.updated_at, :format => :long)}"
    if version.user
      html += " por #{content_tag :span, version.user}" 
    end

    html.html_safe
  end
private
  def render_pagina(pagina)
    {:content => render('paginas/texto_pagina', :pagina => pagina),
    :sidebar => render('paginas/sidebar', :pagina => pagina)}
  end

  def differ(actual, anterior)
    Differ.diff(actual, anterior).to_s.html_safe
  end

  def boton_id(version)
    radio_button_tag :version_id, version.id, false,
                     :title => 'Selecciona como versión posterior en la comparación'
  end

  def boton_referencia(version)
    radio_button_tag :ref_id, version.id, false,
                     :title => 'Selecciona como versión de referencia en la comparación'
  end
end
