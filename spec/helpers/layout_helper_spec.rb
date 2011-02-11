# encoding: utf-8

require 'spec_helper'

describe LayoutHelper do
  describe "#stylesheet" do
    context "adding a stylesheets" do
      before(:each) { helper.stylesheet 'application' }
        
      it 'adds a stylesheet to the list' do
        helper.stylesheets.should include('application')
      end

      it "doesn't add a javascript" do
        helper.javascripts.should_not include('application') 
      end
    end

    context "adding a javascript" do
      before(:each) { helper.javascript 'application' }

      it 'adds a javascript to the list' do
        helper.javascripts.should include('application')
      end

      it "doesn't add a stylesheet" do
        helper.stylesheets.should_not include('application')
      end
    end

  end
end 
