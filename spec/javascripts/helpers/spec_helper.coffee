beforeEach ->
  this.addMatchers({
    toBePlaying: (expectedSong) -> 
      player = this.actual
      player.currentlyPlayingSong == expectedSong && player.isPlaying
  })

  spyOn(jQuery.ajaxSettings, 'xhr').andCallFake ->
    newXhr = new FakeXMLHttpRequest()
    ajaxRequests.push(newXhr)
    newXhr

  clearAjaxRequests()
