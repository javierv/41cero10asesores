# encoding: utf-8

require 'spec_helper'

describe NavegacionCell do
  describe "display" do
    subject { render_cell(:navegacion, :display) }
    it { should have_selector("nav") }

    context "cache", cache: true do
      let(:cache_key) { cell(:navegacion).class.state_cache_key(:display) }

      it "escribe en la caché" do
        Cell::Base.cache_store.read(cache_key).should be_nil
        render_cell(:navegacion, :display)
        Cell::Base.cache_store.read(cache_key).should_not be_nil
      end
    end
  end
end
