# encoding: utf-8
module GoogleMapTag
  def gm(options)
    data = extract_coordinates(options[:text])

    html = %Q{<div class="google_map" data-latitud="#{data[:lat]}" } +
           %Q{data-longitud="#{data[:long]}"}
  
    if data[:titulo]
      html += %Q{data-titulo="#{data[:titulo]}"}
    end

    html + "></div>"
  end

  def extract_coordinates(text)
    text.match /(?<lat>.+),(?<long>[^\(]+)(\((?<titulo>.+)\))?/
  end
end
RedCloth::Formatters::HTML.send(:include, GoogleMapTag)

module TextileHelper
  def strict_textilize(texto)
   sanitize textilize(texto),
      tags:       %w(a acronym strong em li ul ol blockquote br cite sub sup ins p img h2 del div),
      attributes: %w(href src alt class style data-latitud data-longitud data-titulo)
  end
end
