# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/request_helper')

feature "Borrador", %q{
  Para facilitar la publicación de una caja en varias páginas
  Como administrador
  Quiero poder asignar cajas a páginas
} do

  background do
    crea_paginas_con_titulos ["Primera", "Segunda", "Tercera"]
    login
  end
  
  scenario "asignando a una página" do
    visit new_caja_path
    page.should_not have_pagina_asignada
    crea_asignando_pagina "Primera"
    page.should have_success
    page.should have_pagina_asignada
  end
end
