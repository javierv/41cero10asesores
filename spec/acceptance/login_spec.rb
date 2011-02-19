# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Login", %q{
  In order to manage the content
  As an administrator
  I want to be able to log in
} do

  let(:usuario) { Factory :usuario, password: "correcta" }
  background { Capybara.reset_sessions! }

  scenario "con contraseña incorrecta" do
    login_with(email: usuario.email, password: "incorrecta")
    page.should have_error
    current_path.should == login_page
  end

  scenario "con contraseña correcta" do
    login_with(email: usuario.email, password: "correcta")
    page.should have_success
    current_path.should == admin_page
  end

  scenario "desconectando" do
    login_with(email: usuario.email, password: "correcta")
    logout
    current_path.should == login_page
  end
end
