# encoding: utf-8

module HelperMethods
  include Warden::Test::Helpers  

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
    login_as usuario
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

  def crea_pagina(pagina, boton = "Guardar Página")
    visit new_pagina_path
    within("#new_pagina") do
      fill_in "Título", with: pagina[:titulo]
      fill_in "Cuerpo", with: pagina[:cuerpo]
      click_on boton
    end
  end

  def crea_borrador
    # Tengo que rellenar los campos porque el navegador protesta
    # por el atributo required de HTML5.
    crea_pagina({ titulo: "Borrador", cuerpo: "Borrador"}, "Guardar borrador")
  end

  def publica_borrador
    pagina = Factory :pagina, borrador: true
    visit edit_pagina_path(pagina)
    click_on "Publicar"
  end

  def previsualiza_pagina
    crea_pagina({ titulo: "Preview", cuerpo: "Preview"}, "Vista previa")
  end

  def borra_pagina(titulo)
    click_on "Borrar #{titulo}"
  end

  def deshaz_borrado
    click_on "Deshacer"
  end

  def recupera_pagina(titulo)
    click_on "Recuperar #{titulo}"
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

  def crea_nuevo_boletin_con_adjunto(archivo)
    visit new_boletin_path
    fill_in "Título", with: "Título"
    attach_file "Archivo", Rails.root.join("spec", "images", archivo)
    click_on "Guardar"
  end
end

RSpec.configuration.include HelperMethods, type: :request
