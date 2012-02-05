# encoding: utf-8

require 'spec_helper'

describe PortadasController do
  before(:each) do
    @pagina = Factory(:pagina)
    authenticate_usuario
  end

  describe "show" do
    before(:each) do
      @pagina.asigna_portada
      get :show
    end

    it do
      should respond_with(:success)
      assigns(:pagina).should be_true
      should render_template("paginas/show")
    end
  end
end
