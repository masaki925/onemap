# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  exports = this
  mapOptions =
    center: new google.maps.LatLng(-34.397, 150.644),
    zoom: 8,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  map = new google.maps.Map $('#map_canvas').get(0), mapOptions

  markersArray = []
  exports.infowindow = new google.maps.InfoWindow()
  exports.service = new google.maps.places.PlacesService(map)
  directionsDisplay = new google.maps.DirectionsRenderer()
  directionsService = new google.maps.DirectionsService()
  bounds = new google.maps.LatLngBounds()

  spots = $('.spots')
  waypoints = []
  spots.each (index) ->
    switch index
      when 0, spots.length - 1
        console.log "0"
      else
        waypoints.push location:new google.maps.LatLng(spots.find("input#latitude")[index].value, spots.find("input#longitude")[index].value)
  exports.destination = new google.maps.LatLng(spots.find('input#latitude')[spots.length - 1].value, spots.find('input#longitude')[spots.length - 1].value)

  request =
    origin: new google.maps.LatLng(spots.find('input#latitude')[0].value, spots.find('input#longitude')[0].value),
    waypoints: waypoints,
    destination: exports.destination
    travelMode: google.maps.TravelMode.WALKING

  $('.span3').find('button.restaurant').click (e) ->
    clearOverlays()
    request =
      location: exports.destination,
      radius: '500',
      types: ['restaurant']
    exports.service.search request, (results, status) ->
      if status is google.maps.places.PlacesServiceStatus.OK
        for i in [0..results.length]
           place = results[i]
           createMarker(results[i])

  $('.span3').find('button.sight').click (e) ->
    clearOverlays()
    request =
      location: exports.destination,
      radius: '500',
      types: ['restaurant']
    exports.service.search request, (results, status) ->
      if status is google.maps.places.PlacesServiceStatus.OK
        for i in [0..results.length]
           place = results[i]
           createMarker(results[i])

  $('.span3').find('button.hotel').click (e) ->
    clearOverlays()
    request =
      location: exports.destination,
      radius: '500',
      types: ['lodging']
    exports.service.search request, (results, status) ->
      if status is google.maps.places.PlacesServiceStatus.OK
        for i in [0..results.length]
           place = results[i]
           createMarker(results[i])

  directionsService.route request, (results, status) ->
    if status is google.maps.DirectionsStatus.OK
      directionsDisplay.setDirections(results)
      directionsDisplay.setMap(map)

  createMarker = (place) ->
    placeLoc = place.geometry.location
    bounds.extend(placeLoc)
    map.fitBounds(bounds)
    marker = new google.maps.Marker
      map: map,
      position: placeLoc
    markersArray.push(marker)
    request =
      reference: place.reference
    exports.service.getDetails request, (details, status) ->
      google.maps.event.addListener marker, 'click', ->
        exports.infowindow.setContent place.name
        exports.infowindow.open map, this

  clearOverlays = ->
    if markersArray
      for i of markersArray
        markersArray[i].setMap null
    markersArray.length = 0