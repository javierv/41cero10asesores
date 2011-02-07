require = (file) -> 
  document.write('<script type="text/javascript" src="/public/javascripts/' + file + '.js"></script>')

beforeEach ->
  this.addMatchers({
    toHaveLength: (length) -> 
      this.actual.length == length
  })

  spyOn(jQuery.ajaxSettings, 'xhr').andCallFake ->
    newXhr = new FakeXMLHttpRequest()
    ajaxRequests.push(newXhr)
    newXhr

  clearAjaxRequests()
