require 'test_helper'

class VersionsControllerTest < ActionController::TestCase
  def pagina_con_versiones
    pagina = Factory(:pagina, :titulo => 'Título previo')
    pagina.update_attribute(:titulo, 'Título final')
    pagina
  end

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

  context 'compare action' do
    setup do
      @pagina = pagina_con_versiones
      get :compare, :id => @pagina.versions.last.to_param
    end

    should respond_with(:success)
    should assign_to(:pagina)
    should assign_to(:previa)
  end
end
