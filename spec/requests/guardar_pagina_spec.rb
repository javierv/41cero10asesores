# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/request_helper')

feature "Guardar páginas", %q{
  Para añadir contenidos
  Como administrador
  Quiero poder guardar páginas
} do

  background { login }
  
  scenario "crear una nueva página" do
    crea_pagina titulo: "Prueba", cuerpo: "Probando"
    page.should have_success
  end
end
