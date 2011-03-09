# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Enviar boletín", %q{
  Para notificar a los clientes
  Como administrador
  Quiero poder enviar adjunto un boletín
} do

  background do
    crea_clientes ["Juan", "Miguel", "Pedro"]
    crea_boletin "Esta semana arrasamos"
    login
  end

  scenario "adjunto con acentos", js: true do
    crea_nuevo_boletin_con_adjunto "Presentación Añeja.pdf"
    page.should have_content "Presentación Añeja.pdf"
  end
end
