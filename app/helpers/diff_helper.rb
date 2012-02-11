# encoding: utf-8
module DiffHelper
  def diferencias(pagina_actual, pagina_anterior)
    differ render_pagina(pagina_actual), render_pagina(pagina_anterior)
  end

  def texto_version_modificada(version)
    html = "Modificada el #{content_tag :span, l(version.updated_at, format: :long)}"
    if version.user
      html += " por #{content_tag :span, version.user}" 
    end

    html.html_safe
  end
private
  def render_pagina(pagina)
    render('paginas/texto_pagina', pagina: pagina)
  end

  def differ(actual, anterior)
    Differ.diff(actual, anterior).to_s.html_safe
  end
end
