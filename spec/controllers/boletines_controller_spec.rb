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
end
