require 'spec_helper'

describe BoletinesController do
  before(:each) do
    @boletin = Factory :boletin
    authenticate_usuario 
  end

  describe "index" do
    before(:each) { get :index }

    it { should respond_with(:success) }
    it { assigns(:boletines).should be_true }
  end

  describe "new" do
    before(:each) { get :new }

    it { should respond_with(:success) }
    it { assigns(:boletin).should be_true }
  end

  describe "edit" do
    before(:each) { get :edit, id: @boletin.to_param }

    it do
      should respond_with(:success)
      assigns(:boletin).should be_true
    end
  end

  describe "create" do
    context "when model is valid" do
      before(:each) do
        valida_siempre(Boletin)
        post :create, boletin: @boletin.attributes
      end
      
      it { should redirect_to(boletines_path) }
      it { should set_the_flash }
    end
  end

  describe "update" do
    context "when model is valid" do
      before(:each) do
        valida_siempre(Boletin)
        put :update, id: @boletin.to_param, boletin: @boletin.attributes
      end
      
      it do
        should redirect_to(boletines_path)
        should set_the_flash
      end
    end
  end
  
  describe "destroy" do
  # TODO: comentado porque borra el archivo.
  #  before(:each) { delete :destroy, id: @boletin.to_param }

  #  it do
  #    should redirect_to(boletines_path)
  #    should set_the_flash
  #    Boletin.exists?(@boletin.id).should be_false
  #  end
  end

  describe "enviar" do
    before(:each) do
      get :enviar, id: @boletin.to_param
    end

    it do
      should respond_with(:success)
      assigns(:boletin).should be_true
      assigns(:boletin).clientes.should be_true
    end
  end

  describe "email" do
    before(:each) do
      valida_siempre(Boletin)
      put :email, id: @boletin.to_param, boletin: {clientes: ["Fulano <fulano@calesur.com>"]}
    end

    it do
      should redirect_to boletines_path
      should set_the_flash
      ActionMailer::Base.deliveries.should_not be_empty
    end
  end
end
