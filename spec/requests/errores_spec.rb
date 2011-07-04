# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/request_helper')

feature "Errores", %q{
  Para enterarme mejor cuando hay errores
  Como usuario
  Quiero que haya páginas de error legibles.
} do

  scenario "página no encontrada", js: true do
    visit "/no-encontrado"
    page.should have_title text: "Página no encontrada"
  end
end
