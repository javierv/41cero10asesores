$(document).ready ->
  $("<div id='map'></div>").appendTo("#main")
  position = new google.maps.LatLng(37.345107,-5.932638)
  options =
    zoom:       14
    center:     position
    mapTypeId:  google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map(document.getElementById("map"), options)

  marker = new google.maps.Marker
    position:  position
    map:       map
    title:     "Calesur"
