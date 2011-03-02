# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Previsualización", %q{
  Para poder ver lo que estoy editando sin grabar
  Como administrador
  Quiero poder previsualizar páginas
} do

  background { login }
  
  # TODO: Cuando el driver de capybara admita formaction, JS no será necesario.
  # Paradójicamente, además, necesito que se ejecute con javascript desactivado.
  scenario "guardando borrador de página nueva", js: true do
    previsualiza_pagina
    page.should have_title text: "Vista previa"
  end
end
