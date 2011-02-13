# encoding: utf-8

require 'spec_helper'

describe NavegacionesController do
  before(:each) { authenticate_usuario }

  describe "new" do
    before(:each) { get :new }

    it { should render_template(:new) }
  end
    
  describe "update" do
    before(:each) do
      post :create, navegacion: {pagina_id: [1, 2, 3]}
    end

    it { should redirect_to(new_navegacion_path) }
  end      
end
