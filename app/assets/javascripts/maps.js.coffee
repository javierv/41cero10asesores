jQuery.fn.worldMaps = ->
  this.each ->
    $(".osm", $(this)).each ->
      lonlat = new OpenLayers.LonLat(
        $(this).attr("data-longitud"), $(this).attr("data-latitud"))
        .transform( new OpenLayers.Projection("EPSG:4326"), new OpenLayers.Projection("EPSG:900913"))

      map = new OpenLayers.Map(this.id)
      map.addLayer(new OpenLayers.Layer.OSM())

      markers = new OpenLayers.Layer.Markers($(this).attr("data-titulo"))
      map.addLayer(markers)
      markers.addMarker(new OpenLayers.Marker(lonlat))

      map.setCenter(lonlat, 15)

$(document).ready -> $('article.pagina, body.static #main').worldMaps()
