# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  exports = this

  city_name = $("#city_name").text()

  geocoder = new google.maps.Geocoder()
  geocoder.geocode {'address': city_name}, (results, status) ->
    unless status == google.maps.GeocoderStatus.OK
      alert('sorry, something wrong')
    else
      city = results[0].geometry.location
      mapOptions =
        center: city,
        zoom: 12,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      map = new google.maps.Map $('#map_canvas').get(0), mapOptions

      markersArray = []
      exports.infowindow = new google.maps.InfoWindow()
      exports.service = new google.maps.places.PlacesService(map)
      exports.destination = city
      bounds = new google.maps.LatLngBounds()

      $('.span3').find('button.restaurant').click (e) ->
        clearOverlays()
        request =
          location: exports.destination,
          radius: '500',
          types: ['restaurant']
        exports.service.search request, (results, status) ->
          if status is google.maps.places.PlacesServiceStatus.OK
            for i in [0..results.length-1]
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
            for i in [0..results.length-1]
               place = results[i]
               createMarker(results[i])

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

