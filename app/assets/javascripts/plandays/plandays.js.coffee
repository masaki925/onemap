# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  # map funcs start -----------------------------------
  exports = this
  mapOptions =
    zoom: 8,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  map = new google.maps.Map $('#map_canvas').get(0), mapOptions

  markersArray = []
  exports.infowindow = new google.maps.InfoWindow()
  exports.service = new google.maps.places.PlacesService(map)
  directionsService = new google.maps.DirectionsService()
  bounds = new google.maps.LatLngBounds()

  spots = $('.planday_spots li')
  lat_inputs = spots.find("input").filter( ->
    this.id == "latitude" or this.id.match(/.*_spot_attributes_lat$/)
  )
  lng_inputs = spots.find("input").filter( ->
    this.id == "longitude" or this.id.match(/.*_spot_attributes_lng$/)
  )
  ref_inputs = spots.find("input").filter( ->
    this.id == "google_reference" or this.id.match(/.*_spot_attributes_google_reference$/)
  )

  spotsLatLng = []
  waypoints = []
  googleRef = []

  if spots.length > 0
    spots.each (index) ->
      latlng = new google.maps.LatLng(lat_inputs[index].value, lng_inputs[index].value)
      spotsLatLng.push latlng
      googleRef.push ref_inputs[index].value
      switch index
        when 0
          exports.startpoint = spotsLatLng[index]
        when spots.length - 1
          exports.destination = spotsLatLng[index]
        else
          waypoints.push location: spotsLatLng[index]
  else
    city_name = $("#city_name").text()
    geocoder = new google.maps.Geocoder()
    geocoder.geocode {'address': city_name}, (results, status) ->
      unless status == google.maps.GeocoderStatus.OK
        alert 'sorry, something wrong'
      else
        destination = results[0].geometry.location
        map.setCenter destination
        exports.destination = destination
  console.log waypoints
  request =
    origin: exports.startpoint,
    waypoints: waypoints,
    destination: exports.destination
    travelMode: google.maps.TravelMode.WALKING

  directionsService.route request, (results, status) ->
    if status is google.maps.DirectionsStatus.OK
      createGMarker(spotsLatLng, googleRef)
      rendererOptions =
        map: map
        suppressInfoWindows: true
        suppressMarkers: true
      directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions)
      directionsDisplay.setDirections(results)

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

  createGMarker = (spotslatlng, googleref) ->
    console.log spotslatlng
    console.log googleref
    for i in [0..googleref.length - 1]
      createSpotMarker(spotslatlng[i], googleref[i])

  createSpotMarker = (spotslatlng, googleref) ->
    marker = new google.maps.Marker
      map: map,
      position: spotslatlng
    request =
      reference: googleref
    exports.service.getDetails request, (details, status) ->
      google.maps.event.addListener marker, 'click', ->
        console.log details
        info = infoContent(details, details)
        exports.infowindow.setContent(info)
        exports.infowindow.open map, this

  createMarker = (place, i) ->
    placeLoc = place.geometry.location
    bounds.extend(placeLoc)
    map.fitBounds(bounds)
    photos = place.photos
    iconNumber = i + 1
    iconURL = iconURL = 'http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=' + iconNumber + '|7FFF00|000000'
    marker = new google.maps.Marker
      map: map,
      position: placeLoc
      icon: iconURL
    markersArray.push(marker)
    createSideMenu(place, iconURL, iconNumber)
    request =
      reference: place.reference
    exports.service.getDetails request, (details, status) ->
      google.maps.event.addListener marker, 'click', ->
        info = infoContent(details, place)

        info += '<button class="addSpot">場所追加</button></div>'
        exports.infowindow.setContent(info)
        exports.infowindow.open map, this
        $("button.addSpot").on "click", (e) ->
          $("a#add_planday_spot")[0].click()
          calcSpotPosition()
          setRmSpot()
  infoContent = (details, place) ->
    info = '<div class="infowindow">'
    if place
      info += '<span class="gRef" hidden="true">' + place.reference + '</span>' +
              '<span class="gLat" hidden="true">' + place.geometry.location.lat() + '</span>' +
              '<span class="gLng" hidden="true">' + place.geometry.location.lng() + '</span>' +
              '<span class="gName">' + place.name + '</span>' + '<br />'
    if details
      info +=
        '<span class="gAddr">' + details.formatted_address + '</span>' + '<br />' +
        '<span class="gWebsite">' + details.website + '</span>' + '<br />' +
        '<span class="gRating">' + details.rating + '</span>' + '<br />' +
        '<span class="gTel">' + details.formatted_phone_number + '</span>' + '<br />' +
        '<img src=' + photosURL(details.photos, details.icon) + '>' + '<br />'
    info += '</div>'

  photosURL = (photos, details) ->
    if photos
      return photos[0].getUrl({'maxWidth': 150, 'maxHeight': 150})
    else
      return details

  clearOverlays =  ->
    if markersArray
      for i of markersArray
        markersArray[i].setMap null
    markersArray.length = 0
    $('#spot-list').empty()

  searchSpots = (request) ->
    exports.service.search request, (results, status) ->
      if status is google.maps.places.PlacesServiceStatus.OK
        for i in [0..results.length - 1]
           place = results[i]
           createMarker(place, i)
  $src = $('<li><img><p></p></img></li><button>場所追加</button>')
  createSideMenu = (place, iconURL, iconNumber) ->
    $item = $src.clone()
    $item.find('img').attr({'src':iconURL, 'alt':String(iconNumber)})
    $item.find('p').text(place.name)
    $('#spot-list').append($item)
    $item.find('img').on "click", (e) ->
      google.maps.event.trigger markersArray[this.alt - 1], 'click'

  # map funcs end   -----------------------------------

  # planday func start --------------------------------
  setRmSpot = ->
    $("span.rmSpot").on 'click', (e) ->
      e.target.parentNode.parentNode.remove()
      calcSpotPosition()

  calcSpotPosition = ->
    $("#planday_spots li").each ->
      $(this).find("input.hidden").filter( ->
        this.id.match(/.*_position$/)
      )[0].value = ($("#planday_spots li").index this) + 1

  # planday func end   --------------------------------

  setRmSpot()

  $("#planday_spots").bind "cocoon:before-insert", (e, insertedItem) ->
    gName = $(exports.infowindow.content).find("span.gName")[0].textContent
    gRef  = $(exports.infowindow.content).find("span.gRef")[0].textContent
    gLat  = $(exports.infowindow.content).find("span.gLat")[0].textContent
    gLng  = $(exports.infowindow.content).find("span.gLng")[0].textContent
    $(insertedItem).find("input").filter( ->
      this.id.match(/.*_spot_attributes_name$/)
    )[0].value = gName
    $(insertedItem).find("input").filter( ->
      this.id.match(/.*_spot_attributes_google_reference$/)
    )[0].value = gRef
    $(insertedItem).find("input").filter( ->
      this.id.match(/.*_spot_attributes_lat$/)
    )[0].value = gLat
    $(insertedItem).find("input").filter( ->
      this.id.match(/.*_spot_attributes_lng$/)
    )[0].value = gLng

  $("#planday_spots").sortable
    axis: "y"
    handle: ".handle"
    cursor: "crosshair"
    items: "li"
    opacity: 0.4
    scroll: true
    update: ->
      calcSpotPosition()

