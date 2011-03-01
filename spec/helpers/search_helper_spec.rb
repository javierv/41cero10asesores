# encoding: utf-8

require 'spec_helper'

describe SearchHelper do
  describe "highlight" do
    let(:text) { "ipsum lorem y toma ya" }

    it "resalta el término" do
      search_highlight(text, "lorem").should ==
        %q{ipsum <strong class="searched_term">lorem</strong> y toma ya}
    end

    it "resalta varios términos" do
      search_highlight(text, "ipsum lorem").should ==
        %q{<strong class="searched_term">ipsum</strong> } +
        %q{<strong class="searched_term">lorem</strong> y toma ya}
    end

    it "resalta como un término entre comillas" do
      search_highlight(text, %q{"ipsum lorem"}).should ==
        %q{<strong class="searched_term">ipsum lorem</strong> y toma ya}
    end
  end

  describe "total_resultados" do
    let(:records) { %w(uno dos tres cuatro cinco seis siete ocho nueve diez) }
    let(:total_resultados) { lambda {|page = 1| 
        offset = 3 * (page - 1)
        paginados = records[offset..offset + 2]
        paginados.stubs(:limit_value).returns(3)
        paginados.stubs(:total_count).returns(records.length)
        paginados.stubs(:current_page).returns(page)
        helper.total_resultados(paginados)
      }
    }

    it "muestra los resultados de la primera página" do
      total = total_resultados[]
      total.should have_selector ".total_resultados"
      total.should have_selector ".primero", text: "1"
      total.should have_selector ".ultimo", text: "3"
      total.should have_selector ".total", text: "10"
    end

    it "muestra los resultados de otra página" do
      total = total_resultados[2]
      total.should have_selector ".primero", text: "4"
      total.should have_selector ".ultimo", text: "6"
      total.should have_selector ".total", text: "10"
    end

    it "muestra los resultados de la última página" do
      total = total_resultados[4]
      total.should have_selector ".primero", text: "10"
      total.should have_selector ".ultimo", text: "10"
      total.should have_selector ".total", text: "10"
    end

    it "no muestra resultados vacíos" do
      helper.total_resultados([]).should have_selector ".total_resultados", text: "No hay resultados"
    end
  end
end
