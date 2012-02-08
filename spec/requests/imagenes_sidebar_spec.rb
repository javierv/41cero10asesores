# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/request_helper')

feature "Imágenes en sidebar", %q{
  Para mejorar el aspecto visual de las páginas
  Como administrador
  Quiero poder crear cajas que sean imágenes
} do

  background do
    crea_paginas_con_titulos ["primera"]
    login
  end
  
  scenario "nueva caja" do
    crea_caja_con_imagen_en_pagina("primera")
    visit pagina_path("primera") # FIXME: Depende de las rutas.
    page.should have_imagen_en_sidebar
  end
end
