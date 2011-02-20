$(document).ready ->
  $("<div id='map'></div>").appendTo("#main")
  options =
    zoom:       14
    center:     new google.maps.LatLng(37.345107,-5.932638)
    mapTypeId:  google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map(document.getElementById("map"), options)
