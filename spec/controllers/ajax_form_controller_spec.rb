# encoding: utf-8

require 'spec_helper'

describe AjaxFormController do
  before(:each) do
    ['título', 'mulo', 'web', 'css', 'pulómetro', 'html'].each do |titulo|
      Factory :pagina, :titulo => titulo
    end      
    authenticate_usuario
  end

  context 'pidiendo con la URL del índice' do
    before(:each) do
      xhr :get, :autocomplete,
        :name => 'search[titulo_contains]', :term => 'ul', :url => '/paginas'
    end

    it 'devolver lista de resultados' do
      assigns(:resultados).map(&:titulo).should == ['mulo', 'pulómetro', 'título']
    end
  end

  context 'pidiendo con la URL con la acción' do
    before(:each) do
      xhr :get, :autocomplete,
        :name => 'search[titulo_contains]', :term => 'ul', :url => '/paginas/index'
    end

    it 'devolver lista de resultados' do
      assigns(:resultados).map(&:titulo).should == ['mulo', 'pulómetro', 'título']
    end
  end

  context 'con varias palabras' do
    before(:each) do
      xhr :get, :autocomplete,
        :name => 'search[titulo_contains]', :term => 'ul t', :url => '/paginas'
    end

    it 'devolver los que contienen todos los términos' do
      assigns(:resultados).map(&:titulo).should == ['pulómetro', 'título']
    end
  end
end    
