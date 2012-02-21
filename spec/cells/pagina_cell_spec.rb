# encoding: utf-8

require "spec_helper"

describe PaginaCell do
  describe "texto" do
    subject { render_cell :pagina, :texto, Factory(:pagina) }
    it { should have_selector("article header") }
    it { should have_selector("article section") }
  end
end
