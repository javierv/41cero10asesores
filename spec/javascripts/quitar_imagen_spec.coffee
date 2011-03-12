require "quitar_imagen"

describe "Quitar imagen", ->
  beforeEach ->
    loadFixtures "quitar_imagen.html"
    load "quitar_imagen"

  describe "al quitar la imagen", ->
    beforeEach ->
      $("#preview a.quitar_imagen").click()

    it "quita la imagen del textarea", ->
      expect($("textarea").val()).toEqual "Foto: "

