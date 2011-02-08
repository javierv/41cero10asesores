cached_files = {}
require = (file) -> 
  if !cached_files[file]
    script = document.createElement('script')
    script.setAttribute("type","text/javascript")
    script.setAttribute("src", '/public/javascripts/' + file + '.js')
    if (typeof script!="undefined")
      document.getElementsByTagName("head")[0].appendChild(script)
    cached_files[file] = script 

unrequire = (file) ->
  delete cached_files[file]

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
