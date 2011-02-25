# encoding: utf-8

require 'spec_helper'

describe SearchHelper do
  describe "highlight" do
    let(:term) { "lorem" }
    let(:text) { "ipsum lorem y toma ya" }

    it "resalta el término" do
      search_highlight(text, term).should ==
        %q{ipsum <strong class="searched_term">lorem</strong> y toma ya}
    end
  end
end
