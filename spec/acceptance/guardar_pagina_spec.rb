# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Guardar páginas", %q{
  Para añadir contenidos
  Como administrador
  Quiero poder guardar páginas
} do

  let(:usuario) { Factory :usuario, password: "password" }

  background do
    login_with(email: usuario.email, password: "password")
  end
  
  scenario "crear una nueva página" do
    crea_pagina titulo: "Prueba", cuerpo: "Probando"
    page.should have_success
  end
end
