# encoding: utf-8

require 'spec_helper'

describe PaginasController do
  def pagina_falla_validacion
    errors = ActiveModel::Errors.new(Pagina.new)
    errors.add_on_blank(:id)
    Pagina.any_instance.stubs(:errors).returns(errors)
    Pagina.any_instance.stubs(:valid?).returns(false)
  end

  def pagina_valida_siempre
    Pagina.any_instance.stubs(:errors).returns({})
    Pagina.any_instance.stubs(:valid?).returns(true)
  end

  before(:each) do
    @pagina = Factory(:pagina)
    authenticate_usuario
  end

  describe "index" do
    before(:each) { get :index }

    it { should respond_with(:success) }
    it { should assign_to(:paginas) }
    it { should render_with_layout(:application) }
  end

  describe "Índice con AJAX" do
    before(:each) { xhr :get, :index }

    it { should respond_with_content_type(:js) }
    it { should render_template(:index) }
    it { should respond_with(:success) }
    it { should_not render_with_layout }
  end

  describe "new action" do
    before(:each) { get :new }
    it { should render_template(:new) }
  end

  describe "create action" do
    context "when model is invalid" do
      before(:each) do
        pagina_falla_validacion
        post :create, :pagina => @pagina.attributes
      end

      it { should render_template(:new) }
    end

    context "when model is valid" do
      before(:each) do
        pagina_valida_siempre
        post :create, :pagina => @pagina.attributes
      end
      it { should redirect_to(pagina_path(assigns(:pagina))) }
    end

    context "when using preview button" do
      context "with a normal request" do
        before(:each) do
          post :create, :pagina => @pagina.attributes, :preview => true
        end

        it { should render_template(:preview) }
        it { should assign_to(:pagina) }
      end

      context "with an AJAX request" do
        before(:each) do
          xhr :post, :create, :pagina => @pagina.attributes, :preview => true
        end

        it { should render_template(:preview) }
        it { should respond_with_content_type(:js) }
        it { should_not render_with_layout }
      end
    end
  end

  describe "show action" do
    before(:each) do
      get :show, :id => @pagina.to_param
    end
    it { should respond_with(:success) }
  end

  describe "edit action" do
    before(:each) do
      get :edit, :id => @pagina.to_param
    end
    it { should render_template(:edit) }
  end

  describe "update action" do
    context "when model is invalid" do
      before(:each) do
        pagina_falla_validacion
        put :update, :id => @pagina.to_param, :pagina => @pagina.attributes
      end

      it { should render_template(:edit) }
    end

    context "when model is valid" do
      before(:each) do
        pagina_valida_siempre
        put :update, :id => @pagina.to_param, :pagina => @pagina.attributes
      end
      it { should redirect_to(pagina_path(@pagina)) }
    end

    context "when using preview button" do
      context "with a normal request" do
        before(:each) do
          put :update, :id => @pagina.to_param, :pagina => @pagina.attributes, :preview => true
        end

        it { should render_template(:preview) }
        it { should assign_to(:pagina) }
      end

      context "with an AJAX request" do
        before(:each) do
          xhr :put, :update, :id => @pagina.to_param, :pagina => @pagina.attributes, :preview => true
        end

        it { should render_template(:preview) }
        it { should respond_with_content_type(:js) }
        it { should_not render_with_layout }
      end
    end

    context "when saving as draft" do
      context "with a normal request" do
        before(:each) do
          put :update, :id => @pagina.to_param, :pagina => @pagina.attributes, :draft => true
        end

        it { should redirect_to(edit_pagina_path(@pagina.draft)) }
      end

      context "with an AJAX request" do
        before(:each) do
          xhr :put, :update, :id => @pagina.to_param, :pagina => @pagina.attributes, :draft => true
        end

        it { should render_template(:borrador) }
        it { should respond_with_content_type(:js) }
        it { should_not render_with_layout }
      end
    end

    context "when publishing a draft" do
      before(:each) do
        @pagina.save_draft
        @borrador = @pagina.draft
        @action = lambda {put :update, :id => @borrador.to_param, :pagina => @pagina.attributes, :publish => true}
      end
      
      context "when model is valid" do
        before(:each) do
          Pagina.any_instance.stubs(:valid?).returns(true)
          @action.call
        end
        it { should redirect_to(pagina_path(@pagina)) }
      end

      context 'when model is invalid' do
        before(:each) do
          Pagina.any_instance.stubs(:valid?).returns(false)
          @action.call
        end

        it { should render_template(:edit) }
      end
    end
  end

  describe "destroy action" do
    context "with a normal request" do 
      before(:each) { delete :destroy, :id => @pagina.to_param }

      it { should redirect_to(paginas_path) }
      it { should set_the_flash }
      it 'destroy model' do
        assert !Pagina.exists?(@pagina.id)
      end
    end

    context "with an AJAX request" do
      before(:each) { xhr :delete, :destroy, :id => @pagina.to_param }

      it { should_not render_with_layout }
      it { should respond_with(:success) }
    end
  end

  describe "search action" do
    before(:each) { get :search, :q => "buscando" }

    it { should respond_with(:success) }
    it { should assign_to(:paginas) }
  end

  describe 'ver el historial' do
    before(:each) { get :historial, :id => @pagina.to_param }

    it { should respond_with(:success) }
    it { should assign_to(:pagina) }
    it { should assign_to(:versiones) }
  end
end
