# encoding: utf-8

require_relative "../../extras/map_tags.rb"

class MapTagsTest
  include MapTags
end

describe MapTags do
  let(:maptag) { MapTagsTest.new }
  describe "extract_coordinates" do
    let(:block) do
      lambda { |text| maptag.extract_coordinates(text) }
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

  describe "osm maps" do
    let(:html) do
      %Q{<div class="osm" id="openstreetmap" data-latitud="37.34" } +
      %Q{data-longitud="-5.93"></div>}
    end

    let(:input) { "37.34,-5.93" }

    it "genera un mapa de open street map" do
      maptag.osm(text: input).should == html
    end

    context "indicando el título" do
      let(:con_titulo) { input + "(Título)" }

      it "pone el título del marcador" do
        maptag.osm(text: con_titulo).should =~ /data-titulo="Título"/
      end
    end

    context "con título en mayúsculas" do
      let(:con_titulo) { input + "(GUAU)" }

      it "pone el título del marcador" do
        maptag.osm(text: con_titulo).should =~ /data-titulo="GUAU"/
      end
    end
  end
end
