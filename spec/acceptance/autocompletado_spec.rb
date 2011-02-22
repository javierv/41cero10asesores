# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Autocompletado", %q{
  Para filtrar más fácilmente
  Como administrador
  Quiero poder autocompletar la búsqueda
} do

  let(:usuario) { Factory :usuario, password: "password" }

  background do
    ["Cien", "Mil", "Diez mil"].each do |titulo|
      Factory :pagina, titulo: titulo
    end
    login_with(email: usuario.email, password: "password")
  end
  
  scenario "tecleando título en el filtrado", js: true do
    rellena_filtro_titulo("Mil") 
    page.should have_autocomplete_list ["Diez mil", "Mil"]
  end
end
