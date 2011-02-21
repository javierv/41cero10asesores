$(document).ready ->
  $(".google_map").each ->
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
