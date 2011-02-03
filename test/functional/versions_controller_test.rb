# encoding: utf-8

require 'test_helper'

class VersionsControllerTest < ActionController::TestCase
  def pagina_con_versiones
    pagina = Factory(:pagina, :titulo => 'Título previo')
    pagina.update_attribute(:titulo, 'Título final')
    pagina
  end

  should route(:get, "/versions/1/compare/2").
          to(:action => :compare, :id => 1, :ref_id => 2)

  context 'show action' do
    setup do
      @pagina = pagina_con_versiones
      get :show, :id => @pagina.versions.last.to_param
    end
    
    should assign_to(:pagina)
    should respond_with(:success)
  end    

  context 'recover action' do
    setup do
      @pagina = pagina_con_versiones
      put :recover, :id => @pagina.versions.last.to_param
    end
    should assign_to(:pagina)
    should set_the_flash
    should redirect_to("la página recuperada") {@pagina}
  end

  context 'restore action' do
    setup do
      @pagina = pagina_con_versiones
      @pagina.destroy
      put :restore, :id => @pagina.versions.last.to_param
    end
    should set_the_flash
    should redirect_to("listado de páginas") {paginas_path}
  end

  context 'compare action' do
    setup do
      @pagina = pagina_con_versiones
    end

    context 'sin versión de referencia' do
      setup do
        get :compare, :id => @pagina.versions.last.to_param
      end

      should respond_with(:success)
      should assign_to(:pagina)
      should assign_to(:referencia)
    end

    context 'con versión de referencia' do
      setup do
        get :compare, :id => @pagina.versions.last.to_param,
            :ref_id => @pagina.versions.first.to_param
      end

      should respond_with(:success)
    end
  end
end
