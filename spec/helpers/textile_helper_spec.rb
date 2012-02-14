# encoding: utf-8
require 'spec_helper'

class MapTagsTest
  include MapTags
end

describe TextileHelper do
  describe "osm maps" do
    let(:html) do
      %Q{<div class="osm" id="openstreetmap" data-latitud="37.34" } +
      %Q{data-longitud="-5.93"></div>}
    end

    let(:input) { "osm. 37.34,-5.93" }

    # TODO: ejemplos de "strict" que no tengan que ver con el mapa.
    context "con título en mayúsculas" do
      let(:con_titulo) { input + "(GUAU)" }

      it "pone el título del marcador" do
        strict_textilize(con_titulo).should have_selector "[data-titulo='GUAU']"
      end
    end
  end
end
