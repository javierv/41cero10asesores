require 'test_helper'

class PaginasControllerTest < ActionController::TestCase
  tests PaginasController

  setup do
    @pagina = Factory(:pagina)
  end

  context "index action" do
    setup do
      get :index
    end

    should respond_with(:success)
    should assign_to(:paginas)
  end

  context "new action" do
    setup do
      get :new
    end
    should render_template(:new)
  end

  context "create action" do
    context "when model is invalid" do
      setup do
        errors = ActiveModel::Errors.new(Pagina.new)
        errors.add_on_blank(:id)
        Pagina.any_instance.stubs(:errors).returns(errors)
        Pagina.any_instance.stubs(:valid?).returns(false)
        post :create, :pagina => @pagina.attributes
      end

      should render_template(:new)
    end

    context "when model is valid" do
      setup do
        Pagina.any_instance.stubs(:errors).returns({})
        Pagina.any_instance.stubs(:valid?).returns(true)
        post :create, :pagina => @pagina.attributes
      end
      should redirect_to('') {pagina_path(assigns(:pagina))}
    end

    context "when using preview button" do
      context "with a normal request" do
        setup do
          post :create, :pagina => @pagina.attributes, :preview => true
        end

        should render_template(:preview)
        should assign_to(:pagina)
      end

      context "with an AJAX request" do
        setup do
          xhr :post, :create, :pagina => @pagina.attributes, :preview => true
        end

        should render_template(:preview)
        should respond_with_content_type(:js)
        should_not render_with_layout
      end
    end
  end

  context "show action" do
    setup do
      get :show, :id => @pagina.to_param
    end
    should respond_with(:success)
  end

  context "edit action" do
    setup do
      get :edit, :id => @pagina.to_param
    end
    should render_template(:edit)
  end

  context "update action" do
    context "when model is invalid" do
      setup do
        errors = ActiveModel::Errors.new(Pagina.new)
        errors.add_on_blank(:id)
        Pagina.any_instance.stubs(:errors).returns(errors)
        Pagina.any_instance.stubs(:valid?).returns(false)
        put :update, :id => @pagina.to_param, :pagina => @pagina.attributes
      end

      should render_template(:edit)
    end

    context "when model is valid" do
      setup do
        Pagina.any_instance.stubs(:errors).returns({})
        Pagina.any_instance.stubs(:valid?).returns(true)
        put :update, :id => @pagina.to_param, :pagina => @pagina.attributes
      end
      should redirect_to('') {pagina_path(@pagina)}
    end

    context "when using preview button" do
      context "with a normal request" do
        setup do
          put :update, :id => @pagina.to_param, :pagina => @pagina.attributes, :preview => true
        end

        should render_template(:preview)
        should assign_to(:pagina)
      end

      context "with an AJAX request" do
        setup do
          xhr :put, :update, :id => @pagina.to_param, :pagina => @pagina.attributes, :preview => true
        end

        should render_template(:preview)
        should respond_with_content_type(:js)
        should_not render_with_layout
      end
    end

    context "when saving as draft" do
      context "with a normal request" do
        setup do
          put :update, :id => @pagina.to_param, :pagina => @pagina.attributes, :draft => true
        end

        should redirect_to('') {edit_pagina_path(@pagina.draft)}
      end
    end

    context "when publishing a draft" do
      setup do
        @pagina.save_draft
        @borrador = @pagina.draft
        @action = lambda {put :update, :id => @borrador.to_param, :pagina => @pagina.attributes, :publish => true}
      end
      
      context "when model is valid" do
        setup do
          Pagina.any_instance.stubs(:errors).returns({})
          Pagina.any_instance.stubs(:valid?).returns(true)
          @action.call
        end
        should redirect_to('') {pagina_path(@pagina)}
      end

      context 'when model is invalid' do
        setup do
          errors = ActiveModel::Errors.new(Pagina.new)
          errors.add_on_blank(:id)
          Pagina.any_instance.stubs(:errors).returns(errors)
          Pagina.any_instance.stubs(:valid?).returns(false)
          @action.call
        end

        should render_template(:edit)
      end
    end
  end

  context "destroy action" do
    setup do
      delete :destroy, :id => @pagina.to_param
    end

    should redirect_to('index') { paginas_path }
    should set_the_flash
    should "destroy model" do
      assert !Pagina.exists?(@pagina.id)
    end
  end

  context "search action" do
    setup do
      get :search, :q => "buscando"
    end

    should respond_with(:success)
    should assign_to(:paginas)
  end

  context 'ver el historial' do
    setup do
      get :historial, :id => @pagina.to_param
    end

    should respond_with(:success)
    should assign_to(:pagina)
    should assign_to(:versiones)
  end
end
