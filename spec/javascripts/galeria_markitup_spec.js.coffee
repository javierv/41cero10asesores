describe "markitup gallery", ->
  beforeEach ->
    loadFixtures "galeria_markitup"
    $('#galeria').galeriaMarkitup()

  it "hides the insert button", ->
    expect($(".actions")).not.toBeVisible()

  it "adds a link with a title around the image", ->
    expect($("#galeria .foto")).toContain("a[title]")

  describe "al pinchar en la imagen", ->
    request = null
    beforeEach ->
      $('a').click()
      request = mostRecentAjaxRequest()

    it "sends the form via AJAX", ->
      expect(request.url).toEqual "/fotos/1?width=300"
       
    it "inserta la respuesta en el textarea", ->
      request.response success('/images/respuesta.png')
      expect($("textarea").val()).toEqual 'Antes.!/images/respuesta.png!'

  describe "al insertar otra imagen distinta y pinchar", ->
    nueva_request = null
    beforeEach ->
      nueva_foto = $("<div class='foto'><form action='/fotos/2'></form></div>").
        appendTo($("#galeria"))
      nueva_imagen= $("<img src='images/nueva.png'>").prependTo(nueva_foto)
      nueva_imagen.click()
      nueva_request = mostRecentAjaxRequest()

    it "sends the form via AJAX", ->
      expect(nueva_request.url).toEqual "/fotos/2?"
    
