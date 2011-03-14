# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Previsualización", %q{
  Para poder ver lo que estoy editando sin grabar
  Como administrador
  Quiero poder previsualizar páginas
} do

  background { login }
  
  scenario "guardando borrador de página nueva" do
    previsualiza_pagina
    save_and_open_page
    page.should have_title text: "Vista previa"
  end
end
