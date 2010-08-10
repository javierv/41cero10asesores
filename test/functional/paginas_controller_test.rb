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
    should render_template :new
  end

  context "create action" do
    context "when model is invalid" do
      setup do
        errors = ActiveModel::Errors.new(Pagina.new)
        errors.add_on_blank(:id)
        Pagina.any_instance.stubs(:errors).returns(errors)
        Pagina.any_instance.stubs(:valid?).returns(false)
        post :create
      end

      should render_template :new
    end

    context "when model is valid" do
      setup do
        Pagina.any_instance.stubs(:errors).returns({})
        Pagina.any_instance.stubs(:valid?).returns(true)
        post :create
      end
      should redirect_to('') {pagina_path(assigns(:pagina))}
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
    should render_template 'edit'
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

      should render_template :edit
    end

    context "when model is valid" do
      setup do
        Pagina.any_instance.stubs(:errors).returns({})
        Pagina.any_instance.stubs(:valid?).returns(true)
        put :update, :id => @pagina.to_param, :pagina => @pagina.attributes
      end
      should redirect_to('') {pagina_path(@pagina)}
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
end
