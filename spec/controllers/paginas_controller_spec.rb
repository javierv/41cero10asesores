# encoding: utf-8

require 'spec_helper'

describe PaginasController do
  before(:each) do
    @pagina = Factory(:pagina)
    authenticate_usuario
  end

  context "index action" do
    before(:each) do
      get :index
    end

    it { should respond_with(:success) }
    it { should assign_to(:paginas) }
    it { should render_with_layout(:application) }
  end

  context "Índice con AJAX" do
    before(:each) do
      xhr :get, :index
    end

    it { should respond_with_content_type(:js) }
    it { should render_template(:index) }
    it { should respond_with(:success) }
    it { should_not render_with_layout }
  end

  context "new action" do
    before(:each) do
      get :new
    end
    it { should render_template(:new) }
  end

  context "create action" do
    context "when model is invalid" do
      before(:each) do
        errors = ActiveModel::Errors.new(Pagina.new)
        errors.add_on_blank(:id)
        Pagina.any_instance.stubs(:errors).returns(errors)
        Pagina.any_instance.stubs(:valid?).returns(false)
        post :create, :pagina => @pagina.attributes
      end

      it { should render_template(:new) }
    end

    context "when model is valid" do
      before(:each) do
        Pagina.any_instance.stubs(:errors).returns({})
        Pagina.any_instance.stubs(:valid?).returns(true)
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

  context "show action" do
    before(:each) do
      get :show, :id => @pagina.to_param
    end
    it { should respond_with(:success) }
  end

  context "edit action" do
    before(:each) do
      get :edit, :id => @pagina.to_param
    end
    it { should render_template(:edit) }
  end

  context "update action" do
    context "when model is invalid" do
      before(:each) do
        errors = ActiveModel::Errors.new(Pagina.new)
        errors.add_on_blank(:id)
        Pagina.any_instance.stubs(:errors).returns(errors)
        Pagina.any_instance.stubs(:valid?).returns(false)
        put :update, :id => @pagina.to_param, :pagina => @pagina.attributes
      end

      it { should render_template(:edit) }
    end

    context "when model is valid" do
      before(:each) do
        Pagina.any_instance.stubs(:errors).returns({})
        Pagina.any_instance.stubs(:valid?).returns(true)
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

  context "destroy action" do
    context "with a normal request" do 
      before(:each) do
        delete :destroy, :id => @pagina.to_param
      end

      it { should redirect_to(paginas_path) }
      it { should set_the_flash }
      it 'destroy model' do
        assert !Pagina.exists?(@pagina.id)
      end
    end

    context "with an AJAX request" do
      before(:each) do
        xhr :delete, :destroy, :id => @pagina.to_param
      end

      it { should_not render_with_layout }
      it { should respond_with(:success) }
    end
  end

  context "search action" do
    before(:each) do
      get :search, :q => "buscando"
    end

    it { should respond_with(:success) }
    it { should assign_to(:paginas) }
  end

  context 'ver el historial' do
    before(:each) do
      get :historial, :id => @pagina.to_param
    end

    it { should respond_with(:success) }
    it { should assign_to(:pagina) }
    it { should assign_to(:versiones) }
  end
end
