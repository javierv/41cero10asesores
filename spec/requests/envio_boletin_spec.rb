# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/request_helper')

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

  scenario "envía un boletín" do
    visit boletines_path
    click_on "Enviar"
    page.should have_clientes_seleccionados ["Juan", "Miguel", "Pedro"]
    uncheck "Miguel"
    click_on "Enviar"
    page.should have_success
    correo_enviado.bcc.should == %w(juan@elretirao.net pedro@elretirao.net)
  end

  scenario "adjunto con acentos" do
    crea_nuevo_boletin_con_adjunto "Presentación Añeja.pdf"
    page.should have_content "Presentación Añeja.pdf"
  end
end
