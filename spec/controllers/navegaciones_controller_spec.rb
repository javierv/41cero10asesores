# encoding: utf-8

require 'spec_helper'

describe NavegacionesController do
  before(:each) do
    authenticate_usuario
  end

  context "new action" do
    before(:each) do
      get :new
    end

    it { should render_template(:new) }
  end
    
  context "update action" do
    before(:each) do
      post :create, :navegacion => {:pagina_id => [1, 2, 3]}
    end

    it { should redirect_to(new_navegacion_path) }
  end      
end
