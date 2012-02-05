# encoding: utf-8

require 'spec_helper'

describe PortadasController do
  let(:pagina) { Factory :pagina }
  before(:each) { authenticate_usuario }

  describe "show" do
    before(:each) do
      Portada.asigna(pagina)
      get :show
    end

    it do
      should respond_with(:success)
      assigns(:pagina).should be_true
      should render_template("paginas/show")
    end
  end
end
