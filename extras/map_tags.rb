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
