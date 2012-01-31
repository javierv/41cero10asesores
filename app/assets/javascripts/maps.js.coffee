jQuery.fn.worldMaps = ->
  this.each ->

    $(".google_map", $(this)).each ->
      position = new google.maps.LatLng(
        $(this).attr("data-latitud"), $(this).attr("data-longitud")
      )
      options =
        zoom:       14
        center:     position
        mapTypeId:  google.maps.MapTypeId.ROADMAP

      map = new google.maps.Map(this, options)

      marker = new google.maps.Marker
        position:  position
        map:       map

      infowindow = new google.maps.InfoWindow content: $(this).attr("data-titulo")
      google.maps.event.addListener marker, 'click', -> infowindow.open map, marker

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

$(document).ready -> $('article.pagina').worldMaps()
