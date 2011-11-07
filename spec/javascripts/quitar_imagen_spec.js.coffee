# "quitar_imagen"

describe "Quitar imagen", ->
  beforeEach ->
    preloadFixtures "quitar_imagen.html"

  describe "al quitar la imagen", ->
    beforeEach ->
      $("#preview a.quitar_imagen").click()

    it "quita la imagen del textarea", ->
      expect($("textarea").val()).toEqual "Foto: "

