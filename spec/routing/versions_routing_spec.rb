# encoding: utf-8

require 'spec_helper'

describe 'rutas para versiones' do
  it 'para la ref_id en la ruta para comparar' do
    { :get => "/versions/1/compare/2"}.
      should route_to(:controller => "versions", :action => "compare", :id => "1", :ref_id => "2")
  end
end
