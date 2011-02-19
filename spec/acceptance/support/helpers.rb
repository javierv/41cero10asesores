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

  RSpec::Matchers.define :have_error do
    match do |actual|
      actual.has_selector? "#flash_alert"
    end
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
