# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/request_helper')

feature "Login", %q{
  Para gestionar el contenido
  Como administrador
  Quiero poder identificarme
} do

  let(:usuario) { Factory :usuario, password: "correcta" }

  scenario "con contraseña incorrecta" do
    login_with(email: usuario.email, password: "incorrecta")
    page.should have_error
    current_path.should == login_page
  end

  scenario "con contraseña correcta" do
    login_with(email: usuario.email, password: "correcta")
    page.should have_success
    page.should have_admin_navigation
    current_path.should == admin_page
  end

  scenario "desconectando" do
    login_with(email: usuario.email, password: "correcta")
    logout
    page.should_not have_admin_navigation
    current_path.should == login_page
  end

  scenario "accediendo a contenido no autorizado" do
    visit admin_page
    page.should have_error
    current_path.should == login_page
  end
end
