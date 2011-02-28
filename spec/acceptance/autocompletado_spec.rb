# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Autocompletado", %q{
  Para filtrar más fácilmente
  Como administrador
  Quiero poder autocompletar la búsqueda
} do

  let(:usuario) { Factory :usuario, password: "password" }

  background do
    crea_paginas_con_titulos ["Cien", "Mil", "Diez mil"]
    login_with(email: usuario.email, password: "password")
  end
  
  scenario "tecleando título en el filtrado", js: true do
    rellena_filtro_titulo("Mil") 
    page.should have_autocomplete_list ["Diez mil", "Mil"]
  end
end
