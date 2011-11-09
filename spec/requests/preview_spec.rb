# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/request_helper')

feature "Previsualización", %q{
  Para poder ver lo que estoy editando sin grabar
  Como administrador
  Quiero poder previsualizar páginas
} do

  background { login }
  
  scenario "guardando borrador de página nueva" do
    previsualiza_pagina
    page.should have_title text: "Vista previa"
  end
end