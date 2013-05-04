# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  exports = this
  mapOptions =
    center: new google.maps.LatLng(-34.397, 150.644), # initialize
    zoom: 8,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  map = new google.maps.Map $('#map_canvas').get(0), mapOptions

  markersArray = []
  exports.infowindow = new google.maps.InfoWindow()
  exports.service = new google.maps.places.PlacesService(map)
  directionsDisplay = new google.maps.DirectionsRenderer()
  directionsService = new google.maps.DirectionsService()
  bounds = new google.maps.LatLngBounds()

  clearOverlays = ->
    if markersArray
      for i of markersArray
        markersArray[i].setMap null
    markersArray.length = 0

  createMarker = (place) ->
    placeLoc = place.geometry.location
    bounds.extend(placeLoc)
    map.fitBounds(bounds)
    photos = place.photos
    marker = new google.maps.Marker
      map: map,
      position: placeLoc
    markersArray.push(marker)
    request =
      reference: place.reference
    exports.service.getDetails request, (details, status) ->
      google.maps.event.addListener marker, 'click', ->
        if details
          exports.infowindow.setContent(
            '<div class="infowindow">' +
            '<span>' + details.name + '</span>' + '<br />' +
            '<span>' + details.formatted_address + '</span>' + '<br />' +
            '<span>' + details.website + '</span>' + '<br />' +
            '<span>' + details.rating + '</span>' + '<br />' +
            '<span>' + details.formatted_phone_number + '</span>' + '<br />' +
            '<img src=' + photosURL(photos, details.icon) + '>' + '<br />' +
            '</div>'
          )
        else
          exports.infowindow.setContent place.name
        exports.infowindow.open map, this

  $src = $('<li></li><button></button>')
  createSideMenu = (place) ->
    $item = $src.clone()
    $item.text(place.name)
    $('#spot-list').append($item)

  photosURL = (photos, details) ->
    if photos
      return photos[0].getUrl({'maxWidth': 150, 'maxHeight': 150})
    else
      return details

  $('.span3').find('button.restaurant').click (e) ->
    clearOverlays()
    request =
      location: exports.destination,
      radius: '500',
      types: ['meal_delivery', 'meal_takeaway', 'food', 'cafe', 'bar', 'bakery',
      'restaurant']
    searchSpots(request)

  $('.span3').find('button.sight').click (e) ->
    clearOverlays()
    request =
      location: exports.destination,
      radius: '500',
      types: ['amusement_park', 'aquarium', 'art_gallery', 'church', 'casino',
      'department_store', 'hindu_temple', 'mosque', 'museum', 'night_club',
      'park', 'place_of_worship', 'shopping_mall', 'spa', 'stadium',
      'synagogue', 'university', 'zoo']
    searchSpots(request)

  $('.span3').find('button.hotel').click (e) ->
    clearOverlays()
    request =
      location: exports.destination,
      radius: '500',
      types: ['lodging']
    searchSpots(request)

  city_name = $("#city_name").text()
  geocoder = new google.maps.Geocoder()
  geocoder.geocode {'address': city_name}, (results, status) ->
    unless status == google.maps.GeocoderStatus.OK
      alert 'sorry, something wrong'
    else
      destination = results[0].geometry.location
      map.setCenter destination
      exports.destination = destination

  searchSpots = (request) ->
    exports.service.search request, (results, status) ->
      if status is google.maps.places.PlacesServiceStatus.OK
        for i in [0..results.length - 1]
           place = results[i]
           createMarker(place)
