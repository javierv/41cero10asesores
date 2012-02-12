# encoding: utf-8

require 'spec_helper'

describe CajasController do
  def caja_falla_validacion
    falla_validacion(Caja)
  end

  def caja_valida_siempre
    valida_siempre(Caja)
  end

  before(:each) do
    @caja = Factory :caja
    authenticate_usuario
  end

  describe "index" do
    before(:each) { get :index }

    it { should respond_with(:success) }
  end

  describe "new" do
    before(:each) { get :new }
    it { should render_template :new }
  end

  describe "create" do
    context "when model is invalid" do
      before(:each) do
        caja_falla_validacion
        post :create
      end

      it { should render_template :new }
    end

    context "when model is valid" do
      before(:each) do
        caja_valida_siempre
        post :create
      end
      it do
        should respond_with :redirect
        should set_the_flash
      end
    end
  end

  describe "edit" do
    before(:each) { get :edit, id: @caja.to_param }
    it { should render_template 'edit' }
  end

  describe "update" do
    context "when model is invalid" do
      before(:each) do
        caja_falla_validacion
        put :update, id: @caja.to_param, caja: @caja.attributes
      end

      it { should render_template :edit }
    end

    context "when model is valid" do
      before(:each) do
        caja_valida_siempre
        put :update, id: @caja.to_param, caja: @caja.attributes
      end
      it do
        should redirect_to(edit_caja_path(@caja))
        should set_the_flash
      end
    end
  end

  describe "destroy action" do
    context "with a normal request" do 
      before(:each) { delete :destroy, id: @caja.to_param }

      it do
        should redirect_to(cajas_path)
        should set_the_flash
        Caja.exists?(@caja.id).should be_false
      end
    end

    context "with an AJAX request" do
      before(:each) { xhr :delete, :destroy, id: @caja.to_param }

      it do
        should_not render_with_layout
        should respond_with(:success)
      end
    end
  end
end
