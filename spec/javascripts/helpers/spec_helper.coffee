cached_files = {}

require = (file) -> 
  if !cached_files[file]
    cached_files[file] = create_script(file)

load = (file) -> create_script(file)

create_script = (file) ->
  script = document.createElement('script')
  script.setAttribute("type","text/javascript")
  script.setAttribute("src", '/public/javascripts/' + file + '.js')
  if (typeof script!="undefined")
    document.getElementsByTagName("head")[0].appendChild(script)
  script

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
