require 'spec_helper'

describe ClientesController do
  before(:each) do
    @cliente = Factory :cliente
    authenticate_usuario 
  end

  describe "index" do
    before(:each) { get :index }

    it { should respond_with(:success) }
    it { assigns(:clientes).should be_true }
  end

  describe "new" do
    before(:each) { get :new }

    it { should respond_with(:success) }
    it { assigns(:cliente).should be_true }
  end

  describe "edit" do
    before(:each) { get :edit, id: @cliente.to_param }

    it do
      should respond_with(:success)
      assigns(:cliente).should be_true
    end
  end

  describe "create" do
    context "when model is valid" do
      before(:each) do
        valida_siempre(Cliente)
        post :create, cliente: @cliente.attributes
      end
      
      it { should redirect_to(clientes_path) }
      it { should set_the_flash }
    end
  end

  describe "update" do
    context "when model is valid" do
      before(:each) do
        valida_siempre(Cliente)
        put :update, id: @cliente.to_param, cliente: @cliente.attributes
      end
      
      it do
        should redirect_to(clientes_path)
        should set_the_flash
      end
    end
  end

  describe "destroy" do
    context "with a normal request" do
      before(:each) { delete :destroy, id: @cliente.to_param }

      it do
        should redirect_to(clientes_path)
        should set_the_flash
        Cliente.exists?(@cliente.id).should be_false
      end
    end

    context "with an AJAX request" do
      before(:each) { xhr :delete, :destroy, id: @cliente.to_param }

      it do
        should_not render_with_layout
        should respond_with(:success)
      end
    end
  end
end
