require 'test_helper'

class VersionsControllerTest < ActionController::TestCase
  context 'show action' do
    setup do
      with_versioning do
        @pagina = Factory(:pagina, :titulo => 'Título previo')
        @pagina.update_attribute(:titulo, 'Título final')
      end
      get :show, :id => @pagina.versions.last.to_param
    end
    
    should assign_to(:pagina)
    should respond_with(:success)
  end    
end
