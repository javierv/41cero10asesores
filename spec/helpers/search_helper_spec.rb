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
end
