# encoding: utf-8

require 'spec_helper'

describe PaginasController do
  def pagina_falla_validacion
    falla_validacion(Pagina)
  end

  def pagina_valida_siempre
    valida_siempre(Pagina)
  end

  before(:each) do
    @pagina = Factory(:pagina)
    authenticate_usuario
  end

  describe "index" do
    context "sin AJAX" do
      before(:each) { get :index }

      it { should respond_with(:success) }
      it { assigns(:paginas).should be_true }
      it { should render_with_layout(:application) }
    end

    context "con AJAX" do
      before(:each) { xhr :get, :index }

      it { should respond_with_content_type(:js) }
      it { should render_template(:index) }
      it { should respond_with(:success) }
      it { should_not render_with_layout }
    end
  end

  describe "new action" do
    before(:each) { get :new }
    it { should render_template(:new) }
  end

  describe "create action" do
    context "when model is invalid" do
      before(:each) do
        pagina_falla_validacion
        post :create, pagina: @pagina.attributes
      end

      it { should render_template(:new) }
    end

    context "when model is valid" do
      before(:each) do
        pagina_valida_siempre
        post :create, pagina: @pagina.attributes
      end
      it { should redirect_to(pagina_path(assigns(:pagina))) }
      it { should set_the_flash }
    end

    context "when using preview button" do
      context "with a normal request" do
        before(:each) do
          post :create, pagina: @pagina.attributes, preview: true
        end

        it { should render_template(:preview) }
        it { assigns(:pagina).should be_true }
      end

      context "with an AJAX request" do
        before(:each) do
          xhr :post, :create, pagina: @pagina.attributes, preview: true
        end

        it { should render_template(:preview) }
        it { should respond_with_content_type(:js) }
        it { should_not render_with_layout }
      end
    end
  end

  describe "show action" do
    before(:each) do
      get :show, id: @pagina.to_param
    end
    it { should respond_with(:success) }
  end

  describe "edit action" do
    before(:each) do
      get :edit, id: @pagina.to_param
    end
    it { should render_template(:edit) }
  end

  describe "update action" do
    context "when model is invalid" do
      before(:each) do
        pagina_falla_validacion
        put :update, id: @pagina.to_param, pagina: @pagina.attributes
      end

      it { should render_template(:edit) }
    end

    context "when model is valid" do
      before(:each) do
        pagina_valida_siempre
        put :update, id: @pagina.to_param, pagina: @pagina.attributes
      end
      it { should redirect_to(pagina_path(@pagina)) }
      it { should set_the_flash }
    end

    context "when using preview button" do
      context "with a normal request" do
        before(:each) do
          put :update, id: @pagina.to_param, pagina: @pagina.attributes, preview: true
        end

        it { should render_template(:preview) }
        it { assigns(:pagina).should be_true }
      end

      context "with an AJAX request" do
        before(:each) do
          xhr :put, :update, id: @pagina.to_param, pagina: @pagina.attributes, preview: true
        end

        it { should render_template(:preview) }
        it { should respond_with_content_type(:js) }
        it { should_not render_with_layout }
      end
    end

    context "when saving as draft" do
      context "with a normal request" do
        before(:each) do
          put :update, id: @pagina.to_param, pagina: @pagina.attributes, draft: true
        end

        it { should redirect_to(edit_pagina_path(@pagina.draft)) }
        it { should set_the_flash }
      end

      context "with an AJAX request" do
        before(:each) do
          xhr :put, :update, id: @pagina.to_param, pagina: @pagina.attributes, draft: true
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
        @action = -> {put :update, id: @borrador.to_param, pagina: @pagina.attributes, publish: true}
      end
      
      context "when model is valid" do
        before(:each) do
          Pagina.any_instance.stubs(:valid?).returns(true)
          @action[]
        end
        it { should redirect_to(pagina_path(@pagina)) }
        it { should set_the_flash }
      end

      context 'when model is invalid' do
        before(:each) do
          Pagina.any_instance.stubs(:valid?).returns(false)
          @action[]
        end

        it { should render_template(:edit) }
      end
    end
  end

  describe "destroy action" do
    context "with a normal request" do 
      before(:each) { delete :destroy, id: @pagina.to_param }

      it { should redirect_to(paginas_path) }
      it { should set_the_flash }
      it 'destroy model' do
        assert !Pagina.exists?(@pagina.id)
      end
    end

    context "with an AJAX request" do
      before(:each) { xhr :delete, :destroy, id: @pagina.to_param }

      it { should_not render_with_layout }
      it { should respond_with(:success) }
    end
  end

  describe "search action" do
    context "with a normal request" do
      before(:each) { get :search, q: "buscando" }

      it { should respond_with(:success) }
      it { assigns(:paginas).should be_true }
    end

    context "with an AJAX request" do
      before(:each) { xhr :get, :search, q: "buscando" }

      it { should respond_with_content_type(:js) }
      it { should render_template(:search) }
      it { should respond_with(:success) }
      it { should_not render_with_layout }
    end
  end

  describe 'ver el historial' do
    before(:each) { get :historial, id: @pagina.to_param }

    it { should respond_with(:success) }
    it { assigns(:pagina).should be_true }
    it { assigns(:versiones).should be_true }
  end
end
