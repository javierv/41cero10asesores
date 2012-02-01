# encoding: utf-8
module MapTags
  def osm(options)
    data = extract_coordinates(options[:text])

    # FIXME: el atributo id está puesto porque OSM lo necesita
    html = %Q{<div class="osm" id="openstreetmap" data-latitud="#{data[:lat]}" } +
           %Q{data-longitud="#{data[:long]}"}
  
    if data[:titulo]
      html += %Q{ data-titulo="#{data[:titulo]}"}
    end

    html + "></div>"
  end

  def extract_coordinates(text)
    text.match /(?<lat>[^,]+),(?<long>[^\(]+)(\((?<titulo>.+)\))?/
  end
end
RedCloth::Formatters::HTML.send(:include, MapTags)

module TextileHelper
  def strict_textilize(texto)
   sanitize RedCloth.new(texto, [:no_span_caps]).to_html,
      tags:       %w(a acronym strong em li ul ol blockquote br cite sub sup ins p img h2 del div),
      attributes: %w(href id src alt class style data-latitud data-longitud data-titulo)
  end
end
