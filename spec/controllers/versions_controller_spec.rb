# encoding: utf-8

require 'spec_helper'

describe VersionsController do
  before(:each) do
    authenticate_usuario
  end

  def pagina_con_versiones
    pagina = Factory(:pagina, titulo: 'Título previo')
    pagina.update_attribute(:titulo, 'Título final')
    pagina
  end

  let(:pagina) { pagina_con_versiones }

  describe 'show' do
    before(:each) { get :show, id: pagina.versions.last.to_param }
    it { should respond_with(:success) }
  end    

  describe 'recover' do
    before(:each) do
      put :recover, id: pagina.versions.last.to_param
    end

    it do
      should set_the_flash
      should redirect_to(pagina)
    end
  end

  describe 'restore' do
    before(:each) do
      pagina.destroy
      put :restore, id: pagina.versions.last.to_param
    end

    it do
      should set_the_flash
      should redirect_to(paginas_path)
    end
  end

  describe 'compare' do
    context 'sin versión de referencia' do
      before(:each) { get :compare, id: pagina.versions.last.to_param }
      it { should respond_with(:success) }
    end

    context 'con versión de referencia' do
      before(:each) do
        get :compare, id: pagina.versions.last.to_param,
            ref_id: pagina.versions.first.to_param
      end

      it { should respond_with(:success) }
    end
  end

  describe 'borradas' do
    before(:each) { get :borradas }
    it { should respond_with(:success) }
  end
end
