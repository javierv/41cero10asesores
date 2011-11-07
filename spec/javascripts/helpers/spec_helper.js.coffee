window.success = (text) ->
  status: 200,
  responseText: text,
  responseHeaders: {"Content-type": "text/javascript"}

beforeEach ->
  this.addMatchers({
    toHaveLength: (length) ->
      this.actual.length == length
  })

  preloadFixtures("adjuntos", "autosave_form", "ayuda_textile",
    "borrar_ajax", "galeria_markitup", "autocomplete_form",
    "live_form", "paginator", "quitar_imagen", "seleccion_diferencias")

  spyOn(jQuery.ajaxSettings, 'xhr').andCallFake ->
    newXhr = new FakeXMLHttpRequest()
    ajaxRequests.push(newXhr)
    newXhr

  clearAjaxRequests()
