# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Buscador", %q{
  Para encontrar la información
  Como usuario
  Quiero usar el buscador
} do

  background do
    crea_paginas_con_titulos ["Un título", "Dos títulos", "Una cosa", "Dos cosas"]
    Pagina.rebuild_xapian_index
  end

  scenario "búsqueda normal" do
    busca "cosa"
    current_path.should == search_page
    page.should have_search_results ["Una cosa", "Dos cosas"]
    page.should have_highlight "cosa"
  end

  scenario "búsqueda con acentos" do
    busca "título"
    page.should have_search_results ["Un título", "Dos títulos"]
  end

  scenario "búsqueda con errata" do
    busca "títluo"
    page.should have_search_suggestion "título"
  end

  scenario "búsqueda con paginación" do
    Pagina.stubs(:default_per_page).returns(1)
    busca "cosa"
    page.should have_search_results ["Una cosa"]
    page.should have_pagination
  end
end
