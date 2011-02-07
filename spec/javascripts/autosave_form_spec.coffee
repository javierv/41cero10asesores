require 'jquery.form'
require 'jquery.autosave_form'
require 'jquery.effects.core'
require 'jquery.effects.highlight'

describe 'Formulario de guardado', ->
  beforeEach ->
    spyOn(window, 'setInterval').andCallFake( ->
      arguments[0].call() 
    )
    loadFixtures 'autosave_form.html'
    # Si no lo pongo, se carga el archivo antes que las fixtures.
    # Se ve que es el tiempo que tarda en manipular el DOM
    # metiendo los elementos nuevos.
    # No debería ser así, pero bueno.
    waits(100)
    require 'autosave_form'

  it 'hace una petición AJAX', ->
    expect(ajaxRequests).toHaveLength 1

  it 'llama a setInterval', ->
    expect(window.setInterval).toHaveBeenCalled()

  describe 'una vez recibida la respuesta', ->
    request = null
    beforeEach ->
      request = mostRecentAjaxRequest()
      request.response
        status: 200
        responseText:
          '<div class="borrador" id="post_35">Actualizado</div>'
      
    it 'actualiza con la respuesta', ->
      expect($('#actualizado')).toHaveHtml request.responseText

    it 'actualiza el valor del input borrador', ->
      expect($('input[name="post[borrador_id]"]')).toHaveValue 35

  afterEach ->
    unrequire 'autosave_form'
