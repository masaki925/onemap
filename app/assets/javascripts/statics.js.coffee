# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  mapOptions =
    zoom: 10
    center: new google.maps.LatLng(40.714623, -74.006605 )
    mapTypeId: google.maps.MapTypeId.ROADMAP
  map = new google.maps.Map $('#map_canvas').get(0), mapOptions
  service = new google.maps.places.PlacesService(map)
  infowindow = new google.maps.InfoWindow(minWidth:500)
  directionsService = new google.maps.DirectionsService()
  bounds = new google.maps.LatLngBounds()

  createSpotMarker = (latlng, ref, color) ->
    iconURL = 'http://maps.google.com/mapfiles/ms/icons/' + color + '-dot.png'
    marker = new google.maps.Marker
      map: map
      position: latlng
      icon: iconURL
    request =
      reference: ref
    service.getDetails request, (details, status) ->
      google.maps.event.addListener marker, 'click', ->
        info = infoContent(details)

        infowindow.setContent(info)
        infowindow.open map, this
  infoContent = (details) ->
    info = '<div class="infowindow" style="height:85px">'
    info += '<span class="gName">' + details.name + '</span>' + '<br />' +
            '<a href="#myModal" role="button" class="btn" data-toggle="modal">もっと詳しく</a>' +
            '</div>'

  markersArray = []
  ownerMarker = new google.maps.LatLng(40.7588950,  -73.9851310)
  createSpotMarker(ownerMarker,"CoQBeAAAAMGrC7pMTj8WiqHbbzwXjg5Gk4US52fyX5BznvENioUx54E52boP7ekKX0mSn2pyc7v3PwHph8daAa90UCeF_0Mg5Pdur4EVLhNkdq3wrTbgLSwiG4vxX-jNWNVY5TJPNVMOqRTWwGoSe285hNHRN1b_EOpeK9FzZVzYsGldpohQEhAijTrT9969v5tWwsqg_EeKGhSDw0m7-ITuXzEWR8WUZPdYU44Ipg","red")
  friendOne = new google.maps.LatLng(40.6892490, -74.04450)
  createSpotMarker(friendOne,"CpQBggAAAFdB3lCCMv37MHkYUUtOZj0TAT-YT0IqSXF0NZ0W0sMMWaKjhJDaNCqcHCED0YLxUqBbPqIyV3wGsT3v6_AZAiRVxyne_J0P25HbHrwtbe72CaOVoUggNffb6NMTIqeGU0NFhbuEYmheSACga6H7FdJcOvQkYyj4rclM1OFW70OhPfldvckDfB0A_p5IgxHwKBIQsQsGE94etMnGYLEx9a4bMxoUFAmK7qMlVnk86Nq-Su4HONe3p5Y","blue")
  friendTwo = new google.maps.LatLng(40.7736150, -73.97110600000001)
  createSpotMarker(friendTwo,"CnRpAAAAkhBCTSJsbd7AgBX0HTRxKkue7TLP0DjtFQpyc9NXzOLuBVoOSwBoA6ovZWFxfnSeqgSGnSj6V1mhfBA_llPyPf6mzDD2Xl2CBD1NRu_KvQVoqVnLcpMLpLtHQ3Nigdm25QfnTY-h4vATP63U0Bm3JBIQTuU1m3kwffyzIEwgp38_RhoUBS8kY6g327c2DeOfafrdCewDOrs","green")

  request =
    origin: friendTwo,
    waypoints: [location: ownerMarker],
    destination: friendOne
    travelMode: google.maps.TravelMode.WALKING

  directionsService.route request, (results, status) ->
    if status is google.maps.DirectionsStatus.OK
      rendererOptions =
        map: map
        suppressInfoWindows: true
        suppressMarkers: true
      directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions)
      directionsDisplay.setDirections(results)

  searchSpots = (request) ->
    service.search request, (results, status) ->
      if status is google.maps.places.PlacesServiceStatus.OK
        for i in [0..results.length - 1]
           place = results[i]
           createMarker(place, i)

  createMarker = (place, i) ->
    placeLoc = place.geometry.location
    iconNumber = i + 1
    iconURL = 'http://mapicons.nicolasmollet.com/wp-content/uploads/mapicons/shape-default/color-666666/shapecolor-white/shadow-1/border-dark/symbolstyle-color/symbolshadowstyle-no/gradient-bottomtop/number_' + iconNumber + '.png'
    marker = new google.maps.Marker
      map: map
      position: placeLoc
      icon: iconURL
    markersArray.push(marker)

  clearButton = ->
    $('.span5').find('button.plans').removeClass('active')
    $('.span5').find('button.hotel').removeClass('active')

  clearOverlays =  ->
    if markersArray
      for i of markersArray
        markersArray[i].setMap null
    markersArray.length = 0

  $('.span5').find('button.hotel').click (e) ->
    clearButton()
    clearOverlays()
    request =
      location: ownerMarker
      radius: '3000'
      types: ['lodging']
    searchSpots(request)
    $('.span5').find('button.hotel').addClass('active')
    $('.spotList').find('img').attr('src', '/assets/hotels.png')

  $('.span5').find('button.plans').click (e) ->
    clearButton()
    clearOverlays()
    $('.span5').find('button.plans').addClass('active')
    $('.spotList').find('img').attr('src', '/assets/onikiri.png')