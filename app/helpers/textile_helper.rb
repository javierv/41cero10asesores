# encoding: utf-8
module TextileHelper
  def strict_textilize(texto)
   sanitize RedCloth.new(texto, [:no_span_caps]).to_html,
      tags:       %w(a acronym strong em li ul ol blockquote br cite sub sup ins p img h2 del div),
      attributes: %w(href id src alt class style data-latitud data-longitud data-titulo)
  end
end
