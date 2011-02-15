require 'jquery.form'

describe "Galería markitup", ->
  beforeEach ->
    loadFixtures 'galeria_markitup.html'
    load 'galeria_markitup'

  it "oculta el botón de insertar", ->
    expect($(".actions")).not.toBeVisible()

  it "pone título a la imagen", ->
    expect($("img")).toHaveAttr('title')

  describe "al pinchar en la imagen", ->
    request = null
    beforeEach ->
      $('img').click()
      request = mostRecentAjaxRequest()

    it "envía el formulario por AJAX", ->
      expect(request.url).toEqual "/fotos/1?width=300"
       
    it "inserta la respuesta en el textarea", ->
      request.response status: 200, responseText: '/images/respuesta.png'
      expect($("textarea").val()).toEqual 'Antes.!/images/respuesta.png!'

  describe "al insertar otra imagen distinta y pinchar", ->
    nueva_request = null
    beforeEach ->
      nueva_foto = $("<div class='foto'><form action='/fotos/2'></form></div>").
        appendTo($("#galeria"))
      nueva_imagen= $("<img src='images/nueva.png'>").prependTo(nueva_foto)
      nueva_imagen.click()
      nueva_request = mostRecentAjaxRequest()

    it "envía el formulario por AJAX", ->
      expect(nueva_request.url).toEqual "/fotos/2?"
    
