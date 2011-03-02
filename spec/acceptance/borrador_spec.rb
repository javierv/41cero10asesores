# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Borrador", %q{
  Para no publicar cambios sin revisar
  Como administrador
  Quiero poder editar borradores de las páginas
} do

  background do
    login
  end
  
  scenario do
    visit new_pagina_path
    click_on "Guardar borrador"
    page.should have_success text: "Borrador guardado"
  end
end
