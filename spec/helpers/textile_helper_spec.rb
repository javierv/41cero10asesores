# encoding: utf-8
require 'spec_helper'

class GoogleMapTagTest
  include GoogleMapTag
end

describe TextileHelper do
  describe "extract_coordinates" do
    let(:block) do
      lambda { |text| GoogleMapTagTest.new.extract_coordinates(text) }
    end

    it "permite no poner el título" do
      data = block["-5.98,4.33"]
      data[:lat].should == "-5.98"
      data[:long].should == "4.33"
      data[:titulo].should be_nil
    end

    it "permite poner el título" do
      data = block["-5.98,4.33(Título)"]
      data[:lat].should == "-5.98"
      data[:long].should == "4.33"
      data[:titulo].should == "Título"
    end

    it "permite comas en el título" do
      data = block["-5.98,4.33(Título, creo)"]
      data[:lat].should == "-5.98"
      data[:long].should == "4.33"
      data[:titulo].should == "Título, creo"
    end

    it "permite título en mayúsculas" do
      data = block["-5.98,4.33(GUAU)"]
      data[:lat].should == "-5.98"
      data[:long].should == "4.33"
      data[:titulo].should == "GUAU"
    end
  end

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
        strict_textilize(con_titulo).should have_selector "[data-titulo='Título']"
      end
    end


    context "con título en mayúsculas" do
      let(:con_titulo) { input + "(GUAU)" }

      it "pone el título del marcador" do
        strict_textilize(con_titulo).should have_selector "[data-titulo='GUAU']"
      end
    end
  end
end
