# encoding: utf-8

require 'spec_helper'

describe PaginaDecorator do
  before { ApplicationController.new.set_current_view_context }

  describe ".title_for_edit" do
    context "borrador" do
      # TODO: ¿Factories? Creo que abuso de ellas. ¿No vale con un stub?
      subject { PaginaDecorator.new(Factory :pagina, borrador: true)}
      its(:title_for_edit) { should =~ /borrador/ }
    end

    context "publicada" do
      subject { PaginaDecorator.new(Factory :pagina, borrador: false)}
      its(:title_for_edit) { should =~ /página/ }
    end
  end
end
