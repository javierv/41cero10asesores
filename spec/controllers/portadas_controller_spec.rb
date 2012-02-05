# encoding: utf-8

require 'spec_helper'

describe PortadasController do
  let(:portada) { Factory :portada, pagina: Factory(:pagina) }
  before(:each) { authenticate_usuario }

  describe "show" do
    before(:each) { get :show }

    it do
      should respond_with(:success)
      assigns(:pagina).should be_true
      should render_template("paginas/show")
    end
  end

  describe "new" do
    before(:each) { get :new }

    it do
      should respond_with(:success)
      assigns(:paginas).should be_true
    end
  end

  describe "update" do
    before(:each) { put :update, id: portada.to_param,  portada: portada.attributes }

    it do
      should redirect_to(new_portada_path)
      should set_the_flash
    end
  end
end
