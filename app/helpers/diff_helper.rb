module DiffHelper
  def diferencias(pagina_actual, pagina_anterior)
    actual = render_pagina(pagina_actual)
    anterior = render_pagina(pagina_anterior)
    content_for(:sidebar) {differ actual[:sidebar], anterior[:sidebar]}
    differ actual[:content], anterior[:content]
  end

private
  def render_pagina(pagina)
    {:content => render('paginas/texto_pagina', :pagina => pagina),
    :sidebar => render('paginas/sidebar', :pagina => pagina)}
  end

  def differ(actual, anterior)
    Differ.diff(actual, anterior).to_s.html_safe
  end
end
