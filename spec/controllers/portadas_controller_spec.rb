# encoding: utf-8

require 'spec_helper'

describe PortadasController do
  let(:pagina) { Factory :pagina }
  let(:portada) { Factory :portada, pagina_id: pagina.id }
  before(:each) { authenticate_usuario }

  describe "show" do
    before(:each) { get :show }

    it do
      should respond_with(:success)
      assigns(:pagina).should be_true
      should render_template("paginas/show")
    end
  end
end
