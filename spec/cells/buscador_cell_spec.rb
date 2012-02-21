# encoding: utf-8

require 'spec_helper'

describe BuscadorCell do
  describe "display" do
    subject { render_cell(:buscador, :display, "") }

    it { should have_selector "form[role='search']" }
    it { should have_selector "input[type='search']" }
  end
end
