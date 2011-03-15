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
    page.should have_pages_list ["Primera", "Segunda", "Tercera"]

    borra_pagina "Primera"
    page.should have_success(text: "se borró")
    page.should have_pages_list ["Segunda", "Tercera"]

    deshaz_borrado
    page.should have_success(text: "recuperó")
    page.should have_pages_list ["Primera", "Segunda", "Tercera"]
  end

  scenario "Recuperar una página borrada", js: true do
    visit paginas_path
    borra_pagina "Segunda"
    page.should have_pages_list ["Primera", "Tercera"]
    borra_pagina "Primera"

    visit deleted_path
    page.should have_pages_list ["Primera", "Segunda"]

    recupera_pagina "Segunda"
    current_path.should == paginas_path
    page.should have_pages_list ["Segunda", "Tercera"]

    visit deleted_path
    page.should have_pages_list ["Primera"]
  end
end
