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
  
  # TODO: Cuando el driver de capybara admita formaction, JS no será necesario.
  scenario "guardando borrador de página nueva", js: true do
    crea_borrador
    page.should have_success text: "Borrador guardado"
  end

  scenario "publicando un borrador", js: true do
    publica_borrador
    page.should have_success text: "Borrador publicado"
  end
end
