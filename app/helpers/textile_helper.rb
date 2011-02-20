# encoding: utf-8

module GoogleMapTag
  def gm(options)
    latitud, longitud = options[:text].split(",")
    %Q{<div id="map"></div>} +
    "<script>" +
      "$(document).ready(function() { " +
        %Q{$("#map").google_map(#{latitud}, #{longitud})} +
      " }" +
    "</script>"
  end
end

module TextileHelper
  def strict_textilize(texto)
   sanitize textilize(texto),
      tags:       %w(a acronym strong em li ul ol blockquote br cite sub sup ins p img h2 del),
      attributes: %w(href src alt class style)
  end
end
