describe 'adjuntos AJAX', ->
  beforeEach ->
    loadFixtures "adjuntos"
    $('form').adjuntaImagen()

  it 'esconde las acciones', ->
    expect($('input[type="submit"]')).not.toBeVisible()

  it "añade clase si el navegador permite arrastrar y soltar", ->
    if window.FileReader
      expect($("form")).toHaveClass('droppable')
    else
      expect($("form")).not.toHaveClass('droppable')

  # TODO: no sé cómo hacer para adjuntar
  # un archivo al campo de subida.
  # describe "al adjuntar una imagen", ->
  #   beforeEach ->
  #     input = document.getElementById('foto_imagen') 
  #     NO FUNCIONA
  #     spyOn(input, 'files').andCallFake ->
  #       length: 1
  #     $('input:file').val("/images/prueba.png").change()

  #   it "envía el formulario por AJAX", ->
  #     expect(ajaxRequests).toHaveLength 1

  #   describe "al completar la respuesta", ->
  #     beforeEach ->
  #       request = mostRecentAjaxRequest()
  #       request.response status: 200, responseText: '<img src="/images/hola.png">'
  #  
  #     it "añade la imagen a la galería", ->
  #       expect($("#galeria")).toContain('img')

  #     it "no borra el contenido que ya había", ->
  #       expect($("#galeria")).toContain('.prueba')
  #    
