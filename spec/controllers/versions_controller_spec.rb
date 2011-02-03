# encoding: utf-8

require 'spec_helper'

describe VersionsController do
  before(:each) do
    authenticate_usuario
  end

  def pagina_con_versiones
    pagina = Factory(:pagina, :titulo => 'Título previo')
    pagina.update_attribute(:titulo, 'Título final')
    pagina
  end

  context 'show action' do
    before(:each) do
      @pagina = pagina_con_versiones
      get :show, :id => @pagina.versions.last.to_param
    end
    
    it { should assign_to(:pagina) }
    it { should respond_with(:success) }
  end    

  context 'recover action' do
    before(:each) do
      @pagina = pagina_con_versiones
      put :recover, :id => @pagina.versions.last.to_param
    end
    it { should assign_to(:pagina) }
    it { should set_the_flash }
    it { should redirect_to(@pagina) }
  end

  context 'restore action' do
    before(:each) do
      @pagina = pagina_con_versiones
      @pagina.destroy
      put :restore, :id => @pagina.versions.last.to_param
    end
    it { should set_the_flash }
    it { should redirect_to(paginas_path) }
  end

  context 'compare action' do
    before(:each) do
      @pagina = pagina_con_versiones
    end

    context 'sin versión de referencia' do
      before(:each) do
        get :compare, :id => @pagina.versions.last.to_param
      end

      it { should respond_with(:success) }
      it { should assign_to(:pagina) }
      it { should assign_to(:referencia) }
    end

    context 'con versión de referencia' do
      before(:each) do
        get :compare, :id => @pagina.versions.last.to_param,
            :ref_id => @pagina.versions.first.to_param
      end

      it { should respond_with(:success) }
    end
  end
end
