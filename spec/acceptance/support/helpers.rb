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

  def borra_pagina(opciones = { orden: 1 })
    borradores = page.all "a", text: "Borrar"
    borradores[opciones[:orden] -1].click
  end

  def borra_primera_pagina
    borra_pagina
  end

  def deshaz_borrado
    click_on "Deshacer"
  end

  def recupera_pagina(opciones = { orden: 1 })
    recuperadores = page.all 'input[value="Recuperar"]'
    recuperadores[opciones[:orden] -1].click
  end

  def recupera_primera_pagina
    recupera_pagina
  end

  def crea_clientes(nombres)
    nombres.each do |nombre|
      Factory :cliente, nombre: nombre, email: "#{nombre.underscore}@elretirao.net"
    end
  end

  def crea_boletin(titulo)
    Factory :boletin, titulo: titulo
  end

  def correo_enviado
    ActionMailer::Base.deliveries.last
  end

  def crea_foto
    within("#fotos") do
      attach_file "nueva imagen", Rails.root.join("spec", "images", "blank.png")
    end
  end
end

RSpec.configuration.include HelperMethods, type: :acceptance
