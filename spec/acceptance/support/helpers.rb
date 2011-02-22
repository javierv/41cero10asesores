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

  define_match :have_error do |actual|
    actual.has_selector? "#flash_alert"
  end

  define_match :have_success do |actual|
    actual.has_selector? "#flash_notice"
  end

  define_match :have_admin_navigation do |actual|
    actual.has_selector? "#admin"
  end

  define_match :have_autocomplete_list do |page, results|
    list = ".ui-autocomplete"
    page.has_selector?(list) &&
    page.has_selector?("#{list} li", count: results.count) &&
    results.inject(true) do |presentes, result|
      presentes && page.has_selector?("#{list} li", text: result)
    end
  end
end

RSpec.configuration.include HelperMethods, type: :acceptance
