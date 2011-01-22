# encoding: utf-8

require 'test_helper'

class NavegacionesControllerTest < ActionController::TestCase
  context "new action" do
    setup do
      get :new
    end

    should render_template(:new)
  end
    
  context "update action" do
    setup do
      post :create, :navegacion => {:pagina_id => [1, 2, 3]}
    end

    should redirect_to('Editar navegación') {new_navegacion_path}
  end      
end
