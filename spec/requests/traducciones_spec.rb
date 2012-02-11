# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/request_helper')

feature "Traducciones", %q{
  Para determinar los textos de la página
  Como administrador
  Quiero poder hacer traducciones
} do

  let(:lema) { "Mi contable me lo robaron" }
  background do
    # TODO: Hacerlo independiente de si se muestra
    # el lema en la web o no (es decir, probar sólo el valor en la BD)
    TRANSLATION_STORE.store_public_translations(lema: "Lema falso")
    crea_portada
  end

  # TODO: este caso debería probarse con Redis ejecutándose, y hacer otro
  # sin Redis ejecutándose, pero no lo veo claro...
  scenario "traducciones" do
    visit homepage
    page.should_not have_content lema

    login
    visit translations_path
    fill_in "Lema", with: lema
    click_on "Guardar"

    visit homepage
    page.should have_content lema
  end
end
