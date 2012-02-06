# encoding: utf-8

require 'spec_helper'

describe PortadasController do
  before(:each) { authenticate_usuario }
  let(:pagina) { Factory :pagina }

  describe "principal" do
    context "sin portada existente" do
      before(:each) { get :principal }
      # En el entorno de test esto no parece funcionar,
      # igual que pasa con las páginas de errores.
      pending { should respond_with(:missing) }
    end

    context "con portada existente" do
      before(:each) do
        @portada = Factory :portada, pagina: pagina
        get :principal
      end

      it do
        should respond_with(:success)
        assigns(:pagina).should be_true
      end
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
    let(:portada) { Factory :portada, pagina: pagina }
    before(:each) { put :update, id: portada.to_param,  portada: portada.attributes }

    it do
      should redirect_to(new_portada_path)
      should set_the_flash
    end
  end

  describe "create" do
    before(:each) do
      valida_siempre(Portada)
      post :create
    end

    it do
      should redirect_to(new_portada_path)
      should set_the_flash
    end
  end
end
