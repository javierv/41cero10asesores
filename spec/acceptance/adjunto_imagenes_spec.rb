# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Subir imágenes", %q{
  Para meter imágenes en el texto
  Como administrador
  Quiero poder adjuntarlas desde la edición de páginas
} do

  background do
    crea_paginas_con_titulos %w(Prueba)
    login
  end

  scenario "Adjuntar una imagen", js: true do
    visit edit_pagina_path(Pagina.first)
    page.should_not have_selector "#galeria img"
    within("#fotos") do
      attach_file "nueva imagen", Rails.root.join("spec", "images", "blank.png")
    end

    page.should have_selector "#galeria img", count: 1
  end
end
