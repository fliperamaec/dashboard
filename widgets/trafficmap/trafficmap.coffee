class Dashing.Trafficmap extends Dashing.Widget

  ready: ->
    lat  = $(@node).data('lat')
    long = $(@node).data('long')
    zoom = $(@node).data('zoom')

    options =
      zoom: zoom
      center: new google.maps.LatLng(lat,long)
      disableDefaultUI: true
      draggable: false
      scrollwheel: false
      disableDoubleClickZoom: true

    @map = new google.maps.Map $(@node)[0], options
    @traffic = new google.maps.TrafficLayer
    @traffic.setMap(@map)
