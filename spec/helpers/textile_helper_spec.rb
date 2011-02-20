require 'spec_helper'

describe TextileHelper do
  describe "google maps" do
    let(:html) do
      %Q{<div id="map"></div>} +
      "<script>" +
        "$(document).ready(function() { " +
          %Q{$("#map").google_map(37.345107, -5.932638)} +
        " }" +
      "</script>"
    end

    let(:input) { "gm. 37.345107,-5.932638" }

    it "genera un mapa de google" do
      RedCloth.new(input).to_html.should == html
    end
  end
end
