# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Borrar Páginas", %q{
  Para quitar información vieja
  Como administrador
  Quiero borrar páginas y recuperarlas
} do

  background do
    crea_paginas_con_titulos %w(Primera Segunda Tercera)
    login
  end

  scenario "Borrar una página y deshacer", js: true do
    visit paginas_path
    page.should have_content "Primera"
    page.should have_content "Segunda"

    borra_primera_pagina
    page.should have_success(text: "se borró")
    page.should have_no_content "Primera"
    page.should have_content "Segunda"

    deshaz_borrado
    page.should have_success(text: "recuperada")
    page.should have_content "Primera"
    page.should have_content "Segunda"
  end

  scenario "Recuperar una página borrada", js: true do
    visit paginas_path
    borra_pagina(orden: 2)
    page.should have_no_content "Segunda"
    borra_primera_pagina

    visit deleted_path
    page.should have_content "Primera"
    page.should have_content "Segunda"
    page.should have_no_content "Tercera"

    recupera_pagina(orden: 2)
    current_path.should == paginas_path
    page.should have_content "Segunda"
    page.should have_no_content "Primera"

    visit deleted_path
    page.should have_content "Primera"
    page.should have_no_content "Segunda"
  end
end
