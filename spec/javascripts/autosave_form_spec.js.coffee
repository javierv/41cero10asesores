describe 'Formulario de guardado', ->
  beforeEach ->
    spyOn(window, 'setInterval').andCallFake( ->
      arguments[0].call()
    )
    loadFixtures "autosave_form"

  it "makes an AJAX request to the form action", ->
    expect(ajaxRequests).toHaveLength 1
    expect(ajaxRequests[0].url).toEqual $('form').attr('action')

  it 'llama a setInterval', ->
    expect(window.setInterval).toHaveBeenCalled()

  describe 'una vez recibida la respuesta', ->
    request = null
    beforeEach ->
      request = mostRecentAjaxRequest()
      request.response success('<div class="borrador" id="post_35">Actualizado</div>')
      
    it 'actualiza con la respuesta', ->
      expect($('#actualizado')).toHaveHtml request.responseText

    it 'actualiza el valor del input borrador', ->
      expect($('input[name="post[borrador_id]"]')).toHaveValue 35
