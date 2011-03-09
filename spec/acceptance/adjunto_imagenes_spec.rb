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
    page.should_not have_fotos
    crea_foto
    page.should have_fotos count: 1
  end
end
