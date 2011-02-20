require 'spec_helper'

describe TextileHelper do
  describe "google maps" do
    it "genera un mapa de google" do
      input = "gm. 37.345107,-5.932638"
      html = %Q{<div id="map"></div>} +
        "<script>" +
          "$(document).ready(function() { " +
            %Q{$("#map").google_map(37.345107, -5.932638)} +
          " }" +
        "</script>"

      redcloth = RedCloth.new(input)
      redcloth.extend GoogleMapTag

      redcloth.to_html.should == html
    end
  end
end
