# encoding: utf-8
module MapTags
  def gm(options)
    map(options.merge({class: "google_map"}))
  end

  def osm(options)
    map(options.merge({class: "osm", id: "openstreetmap"}))
  end

private
  def map(options)
    data = extract_coordinates(options[:text])

    html = %Q{<div class="#{options[:class]}" data-latitud="#{data[:lat]}" } +
           %Q{data-longitud="#{data[:long]}"}
  
    if data[:titulo]
      html += %Q{ data-titulo="#{data[:titulo]}"}
    end

    if options[:id] # FIXME: está hecho porque OSM necesita una ID
      html += %Q{ id="#{options[:id]}"}
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
