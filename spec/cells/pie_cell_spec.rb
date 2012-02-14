# encoding: utf-8

require 'spec_helper'

describe PieCell do
  context "display" do
    subject { render_cell(:pie, :display) }
    it { should have_selector "footer[role='contentinfo']" }
    it { should have_selector "address .phone" }
  end
end
