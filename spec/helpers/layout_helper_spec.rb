# encoding: utf-8

require 'spec_helper'

describe LayoutHelper do
  describe "#title" do
    let(:title) { 'Mi título' }

    context "with no arguments" do
      before(:each) do
        helper.title title
      end

      it "sets the title" do
        helper.title.should == title
      end

      it "sets it shows the title" do
        helper.show_title?.should be_true
      end
    end

    context "setting not to show the title" do
      before(:each) do
        helper.title title, false
      end

      it "sets the title" do
        helper.title.should == title
      end

      it "sets it doesn't show the title" do
        helper.show_title?.should be_false
      end

      it "doesn't modify show_title called with no arguments" do
        helper.title
        helper.show_title?.should be_false
      end

    end
  end
end 
