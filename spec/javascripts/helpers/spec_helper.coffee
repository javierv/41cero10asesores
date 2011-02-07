cached_files = {}
require = (file) -> 
  if !cached_files[file]
    document.write('<script type="text/javascript" src="/public/javascripts/' + file + '.js"></script>')
    cached_files[file] = file

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
