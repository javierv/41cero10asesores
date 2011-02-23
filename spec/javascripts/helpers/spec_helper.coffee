cached_files = {}

require = (file) -> 
  if !cached_files[file]
    cached_files[file] = create_script(file)

load = (file) ->
    # Si no lo pongo, se carga el archivo antes que las fixtures.
    # Se ve que es el tiempo que tarda en manipular el DOM
    # metiendo los elementos nuevos.
    # No debería ser así, pero bueno.
    waits(30)
    create_script(file)

create_script = (file) ->
  script = document.createElement('script')
  script.setAttribute("type","text/javascript")
  script.setAttribute("src", '/public/javascripts/' + file + '.js')
  if (typeof script!="undefined")
    document.getElementsByTagName("head")[0].appendChild(script)
  script

success = (text) ->
  status: 200,
  responseText: text,
  responseHeaders: {"Content-type": "text/javascript"}

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
