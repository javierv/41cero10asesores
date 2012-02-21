# encoding: utf-8

require "spec_helper"

describe PaginaCell do
  describe "texto" do
    subject { render_cell :pagina, :texto, Factory(:pagina) }
    it { should have_selector("article header") }
    it { should have_selector("article section") }
  end

  describe "caché", cache: true do
    subject { cell(:pagina) }

    context "con una página sin modificar" do
      it { should cache :texto, Factory(:pagina) }
    end

    context "con una página modificada" do
      let(:pagina) { Factory :pagina }
      before(:each) do
        pagina.titulo = pagina.titulo + "!"
      end
      it { should_not cache :texto, pagina }
    end
  end
end
