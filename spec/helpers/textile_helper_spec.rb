# encoding: utf-8
require 'spec_helper'

describe TextileHelper do
  describe "google maps" do
    let(:html) do
      %Q{<div class="google_map" data-latitud="37.34" } +
      %Q{data-longitud="-5.93"></div>}
    end

    let(:input) { "gm. 37.34,-5.93" }

    it "genera un mapa de google" do
      RedCloth.new(input).to_html.should == html
    end

    it "genera el mapa con el ayudante de Rails" do
      textilize(input).should == html
    end

    it "genera el mapa en modo estricto" do
      strict_textilize(input).should == html
    end

    context "indicando el título" do
      let(:con_titulo) { input + "(Título)" }

      it "pone el título del marcador" do
        strict_textilize(con_titulo).should have_selector "div[data-titulo='Título']"
      end
    end
  end
end
