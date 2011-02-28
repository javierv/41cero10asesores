# encoding: utf-8

module HelperMethods
  def login_with(usuario)
    visit login_page
    within("#login") do
      fill_in "Email",       with: usuario[:email]
      fill_in "Contraseña",  with: usuario[:password]
      click_on "Entrar"
    end
  end

  def login
    usuario = Factory :usuario, password: "password"
    login_with(email: usuario.email, password: "password")
  end

  def logout
    visit admin_page
    click_on "Desconectar"
  end

  def rellena_filtro_titulo(titulo)
    visit paginas_path
    within("#filtrador") do
      fill_in "Título", with: titulo
    end
  end

  def busca(texto)
    visit homepage
    within("#buscador") do
      fill_in "q", with: texto
      click_on "Buscar"
    end
  end

  def crea_pagina(pagina)
    visit new_pagina_path
    within("#new_pagina") do
      fill_in "Título", with: pagina[:titulo]
      fill_in "Cuerpo", with: pagina[:cuerpo]
      click_on "Guardar Página"
    end
  end
end

RSpec.configuration.include HelperMethods, type: :acceptance
