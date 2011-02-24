# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Buscador", %q{
  Para encontrar la información
  Como usuario
  Quiero usar el buscador
} do

  background do
    ["Un título", "Dos títulos", "Una cosa", "Dos cosas"].each do |titulo|
      Factory :pagina, titulo: titulo
    end
  end

  scenario "búsqueda normal" do
    busca "cosa"
    current_path.should == search_page
    page.should have_search_results ["Una cosa", "Dos cosas"]
  end

  scenario "búsqueda con acentos" do
    busca "título"
    page.should have_search_results ["Un título", "Dos títulos"]
  end
end
