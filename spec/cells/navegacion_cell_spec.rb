# encoding: utf-8

require 'spec_helper'

describe NavegacionCell do
  describe "display" do
    subject { render_cell(:navegacion, :display) }
    it { should have_selector("nav") }
  end
end
