# encoding: utf-8
module GoogleMapTag
  def gm(options)
    latitud, longitud = options[:text].split(",")
    %Q{<div class="google_map" data-latitud="#{latitud}" } +
    %Q{data-longitud="#{longitud}"></div>}
  end
end
RedCloth::Formatters::HTML.send(:include, GoogleMapTag)

module TextileHelper
  def strict_textilize(texto)
   sanitize textilize(texto),
      tags:       %w(a acronym strong em li ul ol blockquote br cite sub sup ins p img h2 del div),
      attributes: %w(href src alt class style data-latitud data-longitud)
  end
end
