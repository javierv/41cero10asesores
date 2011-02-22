# encoding: utf-8

require 'spec_helper'

describe AjaxFormController do
  include Rails.application.routes.url_helpers
  def default_url_options
    { only_path: true }
  end

  let(:url) { url_for controller: :paginas, action: :index }

  before(:each) do
    ['título', 'mulo', 'web', 'css', 'pulómetro', 'html'].each do |titulo|
      Factory :pagina, titulo: titulo
    end      
    authenticate_usuario
  end

  context 'pidiendo con la URL del índice' do
    before(:each) do
      xhr :get, :autocomplete,
        name: 'search[titulo_contains]', term: 'ul', url: url
    end

    it { assigns(:resultados).map(&:titulo).should == ['mulo', 'pulómetro', 'título'] }
  end

  context 'con varias palabras' do
    before(:each) do
      xhr :get, :autocomplete,
        name: 'search[titulo_contains]', term: 'ul t', url: url
    end

    it 'devolver los que contienen todos los términos' do
      assigns(:resultados).map(&:titulo).should == ['pulómetro', 'título']
    end
  end
end    
