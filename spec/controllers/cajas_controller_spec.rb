# encoding: utf-8

require 'spec_helper'

describe CajasController do
  before(:each) do
    @caja = Factory(:caja)
    authenticate_usuario
  end

  context "index action" do
    before(:each) do
      get :index
    end

    it { should respond_with(:success) }
    it { should assign_to(:cajas) }
  end

  context "new action" do
    before(:each) do
      get :new
    end
    it { should render_template :new }
  end

  context "create action" do
    context "when model is invalid" do
      before(:each) do
        errors = ActiveModel::Errors.new(Caja.new)
        errors.add_on_blank(:id)
        Caja.any_instance.stubs(:errors).returns(errors)
        Caja.any_instance.stubs(:valid?).returns(false)
        post :create
      end

      it { should render_template :new }
    end

    context "when model is valid" do
      before(:each) do
        Caja.any_instance.stubs(:errors).returns({})
        Caja.any_instance.stubs(:valid?).returns(true)
        post :create
      end
      it { should redirect_to(edit_caja_path(assigns(:caja))) }
    end
  end

  context "edit action" do
    before(:each) do
      get :edit, :id => @caja.to_param
    end
    it { should render_template 'edit' }
  end

  context "update action" do
    context "when model is invalid" do
      before(:each) do
        errors = ActiveModel::Errors.new(Caja.new)
        errors.add_on_blank(:id)
        Caja.any_instance.stubs(:errors).returns(errors)
        Caja.any_instance.stubs(:valid?).returns(false)
        put :update, :id => @caja.to_param, :caja => @caja.attributes
      end

      it { should render_template :edit }
    end

    context "when model is valid" do
      before(:each) do
        Caja.any_instance.stubs(:errors).returns({})
        Caja.any_instance.stubs(:valid?).returns(true)
        put :update, :id => @caja.to_param, :caja => @caja.attributes
      end
      it { should redirect_to(edit_caja_path(@caja)) }
    end
  end

  context "destroy action" do
    before(:each) do
      delete :destroy, :id => @caja.to_param
    end

    it { should redirect_to(cajas_path) }
    it { should set_the_flash }
    it 'destroy model' do
      Caja.exists?(@caja.id).should be_false
    end
  end
end
