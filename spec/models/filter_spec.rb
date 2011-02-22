# encoding: utf-8

require 'spec_helper'

describe Filter do
  describe "filter" do
    before(:each) do
      ['título', 'mulo', 'web', 'css', 'pulómetro', 'html'].each do |titulo|
        Factory :pagina, titulo: titulo
      end 
    end

    context "con un término" do
      let(:paginas) { Pagina.filter "search[titulo_contains]", "ul" }

      it "devuelve los que contienen el término" do
        paginas.map(&:titulo).should == ['mulo', 'pulómetro', 'título']
      end
    end

    context "con varios términos" do
      let(:paginas) { Pagina.filter "search[titulo_contains]", "ul t" }

      it "devuelve los que contienen todos los términos" do
        paginas.map(&:titulo).should == ['pulómetro', 'título']
      end
    end
  end
end
