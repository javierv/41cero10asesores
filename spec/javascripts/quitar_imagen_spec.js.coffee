describe "Quitar imagen", ->
  beforeEach ->
    loadFixtures "quitar_imagen"
    $('#preview').imagenesQuitables()

  describe "al quitar la imagen", ->
    beforeEach ->
      $("#preview a.quitar_imagen").click()

    it "quita la imagen del textarea", ->
      expect($("textarea").val()).toEqual "Foto: "

