# encoding: utf-8

require 'test_helper'

class CajasControllerTest < ActionController::TestCase
  tests CajasController

  setup do
    @caja = Factory(:caja)
  end

  context "index action" do
    setup do
      get :index
    end

    should respond_with(:success)
    should assign_to(:cajas)
  end

  context "new action" do
    setup do
      get :new
    end
    should render_template :new
  end

  context "create action" do
    context "when model is invalid" do
      setup do
        errors = ActiveModel::Errors.new(Caja.new)
        errors.add_on_blank(:id)
        Caja.any_instance.stubs(:errors).returns(errors)
        Caja.any_instance.stubs(:valid?).returns(false)
        post :create
      end

      should render_template :new
    end

    context "when model is valid" do
      setup do
        Caja.any_instance.stubs(:errors).returns({})
        Caja.any_instance.stubs(:valid?).returns(true)
        post :create
      end
      should redirect_to('') {edit_caja_path(assigns(:caja))}
    end
  end

  context "edit action" do
    setup do
      get :edit, :id => @caja.to_param
    end
    should render_template 'edit'
  end

  context "update action" do
    context "when model is invalid" do
      setup do
        errors = ActiveModel::Errors.new(Caja.new)
        errors.add_on_blank(:id)
        Caja.any_instance.stubs(:errors).returns(errors)
        Caja.any_instance.stubs(:valid?).returns(false)
        put :update, :id => @caja.to_param, :caja => @caja.attributes
      end

      should render_template :edit
    end

    context "when model is valid" do
      setup do
        Caja.any_instance.stubs(:errors).returns({})
        Caja.any_instance.stubs(:valid?).returns(true)
        put :update, :id => @caja.to_param, :caja => @caja.attributes
      end
      should redirect_to('') {edit_caja_path(@caja)}
    end
  end

  context "destroy action" do
    setup do
      delete :destroy, :id => @caja.to_param
    end

    should redirect_to('index') { cajas_path }
    should set_the_flash
    should "destroy model" do
      assert !Caja.exists?(@caja.id)
    end
  end
end
