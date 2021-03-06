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

      it do
        should respond_with(:success)
        should render_with_layout(:application) 
      end
    end

    context "con AJAX" do
      before(:each) { xhr :get, :index }

      it do
        should respond_with_content_type(:js)
        should render_template(:index)
        should respond_with(:success) 
        should_not render_with_layout 
      end
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
      it do
        should respond_with(:redirect)
        should set_the_flash
      end
    end
  end

  describe "show action" do
    let(:accion) { lambda { get :show, id: @pagina.to_param }}

    context "con usuario identificado" do
      before(:each) { accion.call }
      it { should respond_with(:success) }
    end

    context "sin usuario identificado" do
      before(:each) do
        sign_out @usuario
        accion.call
      end
      it { should respond_with(:success) }
    end
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
      it do
        should redirect_to(pagina_path(@pagina))
        should set_the_flash
      end
    end
  end

  describe "save draft" do
    context "with an existing record" do
      context "with a normal request" do
        before(:each) do
          put :save_draft, id: @pagina.to_param, pagina: @pagina.attributes
        end

        it do
          should redirect_to(edit_pagina_path(@pagina.draft))
          should set_the_flash
        end
      end

      context "with an AJAX request" do
        before(:each) do
          xhr :put, :save_draft, id: @pagina.to_param, pagina: @pagina.attributes
        end

        it do
          should render_template(:save_draft)
          should respond_with_content_type(:js)
          should_not render_with_layout
        end
      end
    end

    context "with a new record" do
      context "with a normal request" do
        before(:each) do
          post :save_draft, pagina: @pagina.attributes
        end

        it do
          should redirect_to(edit_pagina_path(Pagina.where(borrador: true).last))
          should set_the_flash
        end
      end

      context "with an AJAX request" do
        before(:each) do
          xhr :post, :save_draft, pagina: @pagina.attributes
        end

        it do
          should render_template(:save_draft)
          should respond_with_content_type(:js)
          should_not render_with_layout
        end
      end
    end
  end

  describe "publish" do
    before(:each) do
      @pagina.save_draft
      @borrador = @pagina.draft
      @action = -> {put :publish, id: @borrador.to_param, pagina: @pagina.attributes}
    end

    context "when model is valid" do
      before(:each) do
       pagina_valida_siempre
       @action[]
      end

      it do
        should redirect_to(pagina_path(@pagina))
        should set_the_flash
      end
    end

    context 'when model is invalid' do
      before(:each) do
        pagina_falla_validacion
        @action[]
      end

      it do
        should respond_with(:success)
        should render_template(:edit)
      end
    end
  end

  describe "preview" do
    context "for an existing record" do
      context "with a normal request" do
        before(:each) do
          put :preview, id: @pagina.to_param, pagina: @pagina.attributes
        end

        it do
          should render_template(:preview)
        end
      end

      context "with an AJAX request" do
        before(:each) do
          xhr :put, :preview, id: @pagina.to_param, pagina: @pagina.attributes
        end

        it do
          should render_template(:preview)
          should respond_with_content_type(:js)
          should_not render_with_layout
        end
      end
    end

    context "for a new record" do
      context "with a normal request" do
        before(:each) do
          post :preview, pagina: @pagina.attributes
        end

        it do
          should render_template(:preview)
        end
      end

      context "with an AJAX request" do
        before(:each) do
          xhr :post, :preview, pagina: @pagina.attributes
        end

        it do
          should render_template(:preview)
          should respond_with_content_type(:js)
          should_not render_with_layout
        end
      end
    end
  end

  describe "destroy action" do
    context "with a normal request" do 
      before(:each) { delete :destroy, id: @pagina.to_param }

      it do
        should redirect_to(paginas_path)
        should set_the_flash
        assert !Pagina.exists?(@pagina.id)
      end
    end

    context "with an AJAX request" do
      before(:each) { xhr :delete, :destroy, id: @pagina.to_param }

      it do
        should_not render_with_layout
        should respond_with(:success)
      end
    end
  end

  describe "search action" do
    context "with a normal request" do
      before(:each) { get :search, q: "buscando" }

      it do
        should respond_with(:success)
      end
    end

    context "with an AJAX request" do
      before(:each) { xhr :get, :search, q: "buscando" }

      it do
        should respond_with_content_type(:js)
        should render_template(:search)
        should respond_with(:success)
        should_not render_with_layout
      end
    end
  end

  describe 'ver el historial' do
    before(:each) { get :historial, id: @pagina.to_param }

    it do
      should respond_with(:success)
    end
  end
end
