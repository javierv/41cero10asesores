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

  define_match :have_error do |actual|
    actual.has_selector? "#flash_alert"
  end

  define_match :have_success do |actual|
    actual.has_selector? "#flash_notice"
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
