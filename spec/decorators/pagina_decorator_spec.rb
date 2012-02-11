# encoding: utf-8

require 'spec_helper'

describe PaginaDecorator do
  before { ApplicationController.new.set_current_view_context }

  describe "borrador" do
    # TODO: ¿Factories? Creo que abuso de ellas. ¿No vale con un stub?
    subject { PaginaDecorator.new(Factory :pagina, borrador: true)}
    its(:title_for_edit) { should =~ /borrador/ }
    its(:tipo) { should == "Borrador"}
  end

  describe "publicada" do
    subject { PaginaDecorator.new(Factory :pagina, borrador: false)}
    its(:title_for_edit) { should =~ /página/ }
    its(:tipo) { should == "Publicada"}
  end
end
